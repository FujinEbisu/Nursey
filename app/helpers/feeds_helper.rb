module FeedsHelper
  MOOD_EMOJIS = {
    'happy' => '😁',
    'content' => '😊',
    "neutral" => '😐',
    "annoyed" => '😒',
    "unhappy" => '😠',
  }.freeze

  def emoji_for_mood(mood)
    MOOD_EMOJIS[mood.to_s] || '😶'
  end
end
