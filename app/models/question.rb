class Question < ApplicationRecord
  belongs_to :user
  validates :mother_question, presence: true
  after_create :fetch_ai_answer

  private

  def fetch_ai_answer
    ChatbotJob.perform_later(self)
  end
end
