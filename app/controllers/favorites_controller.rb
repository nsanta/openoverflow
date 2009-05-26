class FavoritesController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    current_user.favorite_questions << @question
    respond_to do |format|
      format.js {}
    end
  end
  
  
  
  def destroy
    @favorite = current_user.favorites.find_by_question_id(params[:question_id])
    @favorite.destroy
    respond_to do |format|
      format.js {}
    end
  end

end
