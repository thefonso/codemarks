class PresentCodemarks
  extend ActionView::Helpers::DateHelper

  def self.for(codemarks, current_user = nil, searched_user = nil)
    data = {}
    data[:codemarks] = codemarks.map {|codemark| present(codemark, current_user) }
    data[:pagination] = present_pagination(codemarks)
    data[:users] = present_users(codemarks, current_user, searched_user)
    data
  end

  def self.present(codemark, current_user = nil)
    data = codemark.attributes.slice('id', 'user_id', 'resource_id', 'resource_type', 'created_at', 'updated_at', 'description', 'title', 'group_id', 'private', 'save_count', 'visit_count')
    data.merge!({
      resource: present_resource(codemark.resource),
      topics: codemark.topics.map(&:attributes),
      editable: UserCodemarkAuthorizer.new(current_user, codemark, :edit).authorized?,
      user: PresentUsers.present(codemark.user)
    })
    data['title'] ||= 'No title'
    data
  end

  def self.present_pagination(codemarks)
    {
      :total_pages => codemarks.num_pages
    }
  end

  def self.present_users(codemarks, current_user, searched_user)
    users = codemarks.map(&:user)
    users << current_user
    users << searched_user
    users.compact.uniq.map do |user|
      PresentUsers.present(user)
    end
  end

  def self.present_resource(resource)
    PresentResource.new(resource).present
  end
end
