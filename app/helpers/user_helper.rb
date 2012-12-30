module UserHelper
  def current_user_image
    image_tag(current_user.get(:image), :class => 'user_image') if current_user.get(:image).present?
  end

  def user_image(user)
    image_tag(user.get(:image), :class => 'user_image') if user.get(:image).present?
  end

  def user_email(user)
    content_tag(:div, @user.get(:email), :class => 'email')
  end

  def user_description(user)
    desc = @user.get(:description)
    desc = 'No description provided' if desc.blank?
    content_tag(:div, desc, :class => 'description')
  end

  def user_location(user)
    location = @user.get(:location)
    location = 'No location provided' if location.blank?
    content_tag(:div, location, :class => 'location')
  end

  def user_auth_link(user, provider, current_user)
    return unless current_user && current_user.id == user.id
    authentication = user.authentication_by_provider(provider)
    classes = ["auth btn-auth btn-#{provider} #{provider}"]
    classes << 'authenticated' if authentication
    options = {:class => classes.join(' ')}
    options[:target] = '_blank' if authentication
    target = authentication ? "http://#{provider}.com/#{authentication.nickname}" : "/auth/#{provider}"
    link_to provider_unicode_symbols[provider], target, options
  end

  def provider_unicode_symbols
    {
      :twitter => "&#xe023".html_safe,
      :github => "&#xe028".html_safe
    }
  end
end
