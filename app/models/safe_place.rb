class SafePlace < ApplicationRecord
  has_many :reviews, dependent: :destroy
  geocoded_by :adress
  after_validation :geocode, if: :will_save_change_to_adress?

  serialize :options, coder: JSON

  validates :name, presence: true
  validates :adress, presence: true
  validates :options, presence: true

  OPTIONS = ["Chaise haute", "Espace allaitement", "Espace change", "Espace jeux", "Espace biberons", "Espace sieste enfants", "Bière pour papa"]

  def average_rating
    return 0 if reviews.empty?
    reviews.average(:rating).round(1)
  end

  def rating_count
    reviews.count
  end
end
