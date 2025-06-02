class SafePlace < ApplicationRecord
  has_many :safe_places, dependent: :destroy

  OPTIONS = ["Chaise haute", "Espace allaitement", "Espace change", "Espace jeux", "Espace biberons", "Espace sieste enfants", "Bière pour papa"]
end
