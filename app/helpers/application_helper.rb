# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper

  def logged_in?
    !!current_user
  end

  def is_admin?
    current_user && current_user.admin
  end

  def tag_link(tag)
    link_to(tag , tag_question_path(tag))
  end

  def tag_links(tags)
    tags.map{|tag| tag_link(tag)}.join('')
  end


end
