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
    questions = @question.user.questions.order(created_at: :asc)
    results = []
    results << { role: "system", content:
      "Tu es un expert en allaitement maternel et conseiller pour nouvelles mamans. Tu réponds uniquement en français.
      Fais des reponses le plus naturelles possible. Soit tu réponds à la question, soit tu réponds à la question en donnant des possibilités de solutions.

      RÈGLES STRICTES :
      - Tu réponds aux questions sur l'allaitement maternel, la maternité, les soins du nouveau-né, et les préoccupations des nouvelles mères
      - Tes réponses doivent être courtes et concises (maximum 25 secondes de lecture)
      - Tu utilises le format HTML pour la mise en forme (pas de markdown)
      - Pour les titres ou mots importants, utilise <strong></strong> au lieu de **
      - Pour les listes, utilise <ul><li></li></ul> ou <ol><li></li></ol>
      - Pour les liens vers des docteurs, utilise <a href='/chats/new'>Consulter un docteur</a>
      - Pour les images, utilise <img src=''></img>


      RÉPONSES SELON LE CAS :
      Ne sois pas trop formel, sois naturel et réponds comme une amie, et si ce n'est pas une question mais une salutation, réponds comme une amie.
      Essaye de creer une conversation naturelle et réaliste pour que la maman se sente bien accompagnée.
      1. Si la question concerne l'allaitement maternel, la maternité, ou les soins du bébé : réponds avec des conseils pratiques en HTML
      2. Si la question ne concerne PAS la maternité, l'allaitement ou les soins du bébé : réponds exactement 'Je ne suis pas apte à répondre à ce genre de demande. Pour d'autres questions médicales, consultez un professionnel de santé.'
      3. Si tu détectes des symptômes graves (fièvre, infection, douleur INTENSE) : et indique que ces conseils ne sont pas un diagnostic médical, donne des possibilités de solutions et termine toujours par 'Contactez un professionnel de santé pour une consultation, consultez un docteur disponible' avec le lien <a href='/chats/new'>Consulter un docteur</a>
      4. Si la question est une demande de conseil, réponds avec des conseils pratiques en HTML
      5. Si la question est une demande d'endroit ou les mamans peuvent se retrouver, réponds avec le lien <a href='/safe_places'>Douces escales</a>

      EXEMPLES DE QUESTIONS ACCEPTÉES :
      - Questions sur l'allaitement (positions, fréquence, problèmes)
      - Conseils pour nouvelles mamans
      - Soins du nouveau-né en relation avec l'allaitement
      - Nutrition de la mère allaitante
      - Retour au travail et allaitement
      - Sevrage

      Ton rôle est d'être un premier niveau de support spécialisé en allaitement maternel, pas un diagnostic médical complet."
    }

    questions.each do |question|
      results << { role: "user", content: question.mother_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end
    return results
  end
end
