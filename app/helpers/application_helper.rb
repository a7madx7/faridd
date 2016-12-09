module ApplicationHelper
  def resource_name
    :name
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings(:user)
  end

  def icon_for(user)
    icon = ''
    case user.profession.downcase
      when 'student'
        icon = 'student'
      when 'pharmacist', 'doctor', 'physician'
        icon = 'doctor'
      when 'other', 'company'
        icon = 'users'
      else
        icon = 'idea'
    end
  end

  def fine name
    name.gsub('"', '').upcase
  end
end
