module RatingsHelper
  STAR_RATINGS = {
    '1' => '⭐',
    '2' => '⭐',
    "3" => '⭐',
    "4" => '⭐',
    "5" => '⭐',
  }.freeze

  def stars_for_rating(rating)
    STAR_RATINGS[rating.to_s] || '⭐'
  end
end
