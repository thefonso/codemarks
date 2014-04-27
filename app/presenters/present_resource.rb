class PresentResource
  def self.present(resources)
    resources.map { |resource | new(resources).present }
  end

  def initialize(resource)
    @resource = resource
  end

  def present
    attrs = base_attributes
    attrs.merge!(type_specific_attributes)
    attrs['user'] = PresentUsers.present(@resource.author) if @resource.author
    attrs
  end

  def base_attributes
    {
      'id' => @resource.id,
      'clicks_count' => @resource.clicks_count,
      'codemarks_count' => @resource.codemarks_count,
      'type' => @resource.type,
      'author_id' => @resource.author_id
    }
  end

  def type_specific_attributes
    self.send("#{@resource.type.downcase}_attributes")
  end

  def link_attributes
    {
      'url' => @resource.url,
      'host' => @resource.host,
      'snapshot_url' => @resource.snapshot_url
    }
  end

  def text_attributes
    {
      'text' => @resource.text,
      'html' => Global.render_markdown(@resource.text)
    }
  end

  def filemark_attributes
    {
      'attachment_file_name' => @resource.attachment_file_name,
      'attachment_url' => @resource.attachment.url,
      'attachment_size' => @resource.kilabytes_in_words
    }
  end

  def repository_attributes
    {
      'title' => @resource.title,
      'description' => @resource.description,
      'forks_count' => @resource.forks_count,
      'stargazers_count' => @resource.stargazers_count,
      'watchers_count' => @resource.watchers_count,
      'language' => @resource.language,
      'owner_login' => @resource.owner_login,
      'url' => @resource.url
    }
  end
end