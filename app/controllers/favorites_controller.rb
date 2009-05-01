class FavoritesController < ApplicationController

  def create
    @question = Question.find(params[:id])
    current_user.favorite_questions << @question
  end
  
  def destroy
    @favorite = current_user.favorites.find_by_question_id(params[:id])
    @favorite.destroy
  end

end
