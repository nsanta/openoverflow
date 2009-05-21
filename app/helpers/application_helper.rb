# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper

  def logged_in?
    !!current_user
  end

  def is_admin?
    current_user && current_user.admin
  end

  def tag_link(tag , klass = nil)
    link_to(tag , tag_question_path(tag) , :class => klass)
  end

  def tag_links(tags)
    tags.map{|tag| tag_link(tag)}.join('')
  end

  def safe_textilize( s )
    if s && s.respond_to?(:to_s)
      doc = RedCloth.new( s.to_s )
      doc.filter_html = true
      doc.to_html
    end
  end


end
