# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper

  def logged_in?
    !!current_user
  end

  def is_admin?
    current_user && current_user.admin
  end

  def tag_link (tag , klass = nil)
    link_to(tag , tag_question_path(tag) , :class => klass)
  end

  def tag_links (tags)
    tags.map{|tag| tag_link(tag)}.join('')
  end

  def favorite_link (question)
    if current_user.favorite_questions.include?(question)
      text = 'favorite' 
      rel = 'delete'
    else  
      text = 'no favorite'
      rel = 'post'
    end  
    link_to(text , question_favorites_path(question) , :rel => rel , :class => 'favorite_link')
  end

 
end
