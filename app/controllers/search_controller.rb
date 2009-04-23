class SearchController < ApplicationController
  skip_before_filter :require_user 

  def index
    @questions = Question.find_by_tsearch(params[:q]).paginate(:page => params[:page] || 1 , :per_page => 20)
    render "questions/index"
  end

end
