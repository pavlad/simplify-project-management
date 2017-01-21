module ApplicationHelper
  def resource_name

    :user

  end

  def resource

    @resource ||= User.new

  end

  def devise_mapping

    @devise_mapping ||= Devise.mappings[:user]

  end

  def attachinary_presets
    {class: "ui mini circular image", transformation: [width: 25, height: 25, crop: "fill", quality: 100, gravity: "face"]}
  end

  def attachinary_presets_consultant_details
    {transformation: [width: 200, height: 200, crop: "fill", quality: 100, gravity: "face"]}
  end

  def shorten_string(string, character_limit=30)
    string.truncate(character_limit, separator: ' ')
  end
end
