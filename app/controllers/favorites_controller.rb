class FavoritesController < ApplicationController

  def create
    @question = Question.find(params[:id])
    current_user.favorite_questions << @question
    respond_to do |format|
      format.js {}
    end
  end
  
  
  
  def destroy
    @favorite = current_user.favorites.find_by_question_id(params[:id])
    @favorite.destroy
    respond_to do |format|
      format.js {}
    end
  end

end
