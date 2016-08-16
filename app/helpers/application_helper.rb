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
end
