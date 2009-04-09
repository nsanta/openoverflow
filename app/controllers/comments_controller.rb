class CommentsController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @comment = Comment.new(:model => @question , :body => params[:body] , :user => current_user)
    if @comment.save
    else
    end
  end

end
