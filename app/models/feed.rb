class Feed < ApplicationRecord
  belongs_to :mother
  belongs_to :child, optional: true
  enum mood: {
    happy: 5,
    content: 4,
    neutral: 3,
    annoyed: 2,
    unhappy: 1
  }

   attr_accessor :time_right_minutes, :time_right_seconds, :time_left_minutes, :time_left_seconds

  # Initial setup for form display
  after_initialize :set_time_virtuals

  # Combine virtuals into time_right before validation
  before_validation :combine_time_virtuals

  # Validations
  validates :time_right_minutes,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    allow_blank: true

  validates :time_right_seconds,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 60 },
    allow_blank: true

  validates :time_left_minutes,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    allow_blank: true

  validates :time_left_seconds,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 60 },
    allow_blank: true

  validate :non_zero_duration

   private

  # Remplit les champs virtuels si time_right est présent
  def set_time_virtuals
    return if time_right.nil?
    return if time_right_minutes.present? && time_right_seconds.present?
    self.time_right_minutes = time_right / 60
    self.time_right_seconds = time_right % 60

    return if time_left.nil?
    return if time_left_minutes.present? && time_left_seconds.present?
    self.time_left_minutes = time_left / 60
    self.time_left_seconds = time_left % 60
  end

  # Combine les champs virtuels pour obtenir la durée totale en secondes
  def combine_time_virtuals
    return if time_right_minutes.blank? || time_right_seconds.blank?
    self.time_right= time_right_minutes.to_i * 60 + time_right_seconds.to_i
     return if time_left_minutes.blank? || time_left_seconds.blank?
    self.time_left = time_left_minutes.to_i * 60 + time_left_seconds.to_i
    
  end

  # Validation personnalisée pour éviter une durée nulle
  def non_zero_duration
    return if time_right_minutes.blank? || time_right_seconds.blank?
    return if time_left_minutes.blank? || time_left_seconds.blank?

    if time_right_minutes.to_i == 0 && time_right_seconds.to_i == 0
      errors.add(:base, "La durée ne peut pas être 0 seconde")
    if time_left_minutes.to_i == 0 && time_left_seconds.to_i == 0
      errors.add(:base, "La durée ne peut pas être 0 seconde")
    end
  end
end
end
