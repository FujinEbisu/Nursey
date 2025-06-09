class SafePlace < ApplicationRecord
  has_many :reviews, dependent: :destroy
  geocoded_by :adress
  after_validation :geocode, if: :will_save_change_to_adress?

  serialize :options, coder: JSON

  validates :name, presence: true
  validates :adress, presence: true
  validates :options, presence: true

  OPTIONS = ["Chaise haute", "Espace allaitement", "Espace change", "Espace jeux", "Espace biberons", "Espace sieste enfants", "Bière pour papa"]
end
