module FeedsHelper
  MOOD_EMOJIS = {
    'happy' => '😁',
    'content' => ':neutral_face:',
    'sad' => ':cry:'
  }.freeze

  def emoji_for_mood(mood)
    MOOD_EMOJIS[mood.to_s] || ':question:'
  end
end
