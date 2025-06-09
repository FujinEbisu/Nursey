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

  def minutes_and_seconds(time_value)
    return "" unless time_value.present?

    # total_seconds = (time_value.hour * 60) + time_value.min
    minutes = time_value.hour
    seconds = time_value.min
    "#{minutes} min #{seconds} s"
  end
end
