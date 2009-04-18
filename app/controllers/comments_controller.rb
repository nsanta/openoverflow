class CommentsController < ApplicationController
  before_filter :load_answer 
  skip_before_filter :verify_authenticity_token


  def create
    @comment = @answer.comments.build(params[:comment])  
    if @comment.save
      flash[:notice] = 'El comentario ha sido guardado'
    else
      flash[:notice] = 'El comentario NO ha sido guardado'
    end
    respond_to do |format|
      format.js {}
    end
  end
  
  
  
  
  
  
  protected
  
  def load_answer
    @answer = Answer.find(params[:id])
  end

end
