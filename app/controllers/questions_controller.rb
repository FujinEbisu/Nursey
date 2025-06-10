class QuestionsController < ApplicationController
before_action :set_mother, :set_doctor, only: [:index]


    def index
      @questions = current_user.questions
      @question = Question.new
    end

    def create
        @questions = current_user.questions # needed in case of validation error
        @question = Question.new(question_params)
        @question.user = current_user
    if @question.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:questions, partial: "questions/question",
            locals: { question: @question })
        end
        format.html { redirect_to questions_path }
      end
    else
     render :index, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:mother_question)
  end

    def set_mother
      @mother = current_user.userable if current_user.userable.is_a?(Mother)
    end

    def set_doctor
      @doctor = current_user.userable if current_user.userable.is_a?(Doctor)
    end
end
