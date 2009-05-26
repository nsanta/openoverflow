class HomeController < ApplicationController
  skip_before_filter :require_user
 

  def index
    @questions = Question.paginate(:page => params[:page]|| 1 , :per_page => 20 , :order => 'created_at DESC')
  end

  def badges
    @badges = Badge.all(:order => 'level ASC')
  end

end
