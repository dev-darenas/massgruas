module ApplicationHelper
  require 'open-uri'
  include Pagy::Frontend

  def embed_remote_image(url, content_type)
    asset = open(url, "r:UTF-8") { |f| f.read }
    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
    "data:#{content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  $TYPE_NOTIFICATION = {
    "notice": "success",
    "error": "danger"
  }

  def type_notification(key)
    $TYPE_NOTIFICATION[key.to_sym]
  end

  def alert_error(model)
    if model.errors.any?
      html_list = ''
      model.errors.full_messages.each do |message|
        html_list += content_tag(:li, message)
      end
      content_tag(:div, content_tag(:ul, html_list.html_safe), class: "alert alert-dismissible fade show alert-#{type_notification("error")}")
    end
  end
end
