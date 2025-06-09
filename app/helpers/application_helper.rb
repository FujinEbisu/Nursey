module ApplicationHelper
  def theme_class
    if signed_in? && current_user.userable.is_a?(Doctor)
      return 'doctor-theme'
    elsif signed_in? && current_user.userable.is_a?(Mother)
      return 'mother-theme'
    else
      return ''
    end
  end
end
