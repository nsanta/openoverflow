class FlagsController < ApplicationController
  before_filter :load_flaggeable 
  skip_after_filter :store_location

  layout false

  

  def new
  end

  def create
    @flag = Flag.new(:user => current_user , :flaggeable => @flaggeable , :body => params[:body])
    if @flag.save
      flash[:notice]= t("flash.notice.flag.create.valid")
    else
      flash[:notice]= t("flash.notice.flag.create.invalid")
    end
    redirect_back_or_default(root_path)
  end

 

  protected
  
  def load_flaggeable
    if params[:question_id]
      @flaggeable = Question.find(params[:question_id])
    elsif params[:answer_id]
      @flaggeable = Answer.find(params[:answer_id])
#    elsif params[:comment_id]
#      @flaggeable = Comment.find(params[:comment_id])
    end
  end


end
