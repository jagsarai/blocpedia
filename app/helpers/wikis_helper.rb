module WikisHelper
  def user_is_authorized_for_wiki?(wiki)
    current_user && (current_user.id == wiki.user.id) || current_user.admin?
  end
end
