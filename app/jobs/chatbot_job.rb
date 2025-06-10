class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai
      }
    )

      ai_content = chatgpt_response["choices"][0]["message"]["content"]
      
    question.update(ai_answer: ai_content)
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question",
      locals: { question: question }
    )
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []
    results << { role: "system", content:
      "Tu es un expert en allaitement maternel. Tu réponds uniquement en français.
      Fais des reponses le plus naturelles possible. Soit tu réponds à la question, soit tu réponds à la question en donnant des possibilités de solutions.

RÈGLES STRICTES :
- Tu réponds UNIQUEMENT aux questions sur l'allaitement maternel
- Tes réponses doivent être courtes et concises (maximum 25 secondes de lecture)
- Tu utilises le format HTML pour la mise en forme (pas de markdown)
- Pour les titres ou mots importants, utilise <strong></strong> au lieu de **
- Pour les listes, utilise <ul><li></li></ul> ou <ol><li></li></ol>

RÉPONSES SELON LE CAS :
1. Si la question concerne l'allaitement maternel : réponds avec des conseils pratiques en HTML
2. Si la question ne concerne PAS l'allaitement maternel : réponds exactement 'Je ne suis pas apte à répondre à ce genre de demande. Pour d'autres questions médicales, consultez un professionnel de santé.'
3. Si tu détectes des symptômes graves (fièvre, infection, douleur INTENSE) : donne des possibilités de solutions et termine toujours par 'Pour une consultation, consultez un docteur disponible et ajoute un lien vers la page d'accueil de notre plateforme. href='#'"


LIMITE DE QUESTIONS : Si l'utilisateur pose plus de 3 questions consécutives, réponds : 
'Je vous conseille de consulter directement un expert en allaitement maternel pour un suivi personnalisé. 
Vous pouvez accéder au chat avec un docteur disponible via notre plateforme. 

Ton rôle est d'être un premier niveau de support, pas un diagnostic médical complet."
    }

    questions.each do |question|
      results << { role: "user", content: question.mother_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end
    return results
  end
end
