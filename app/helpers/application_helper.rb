module ApplicationHelper
  def theme_class
    if current_user.userable.is_a?(Doctor)
      return 'doctor-theme'
    elsif current_user.userable.is_a?(Mother)
      return 'mother-theme'
    else
      return ''
    end
  end
end
