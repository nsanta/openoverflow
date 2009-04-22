class AnswersController < ApplicationController
  before_filter :load_question , :except => [:vote , :select , :flag]
  skip_before_filter :verify_authenticity_toke


  def create
    @answer = @question.answers.build(:user => current_user , :body => params[:body])
    if @answer.save
      flash[:notice] = "La respuesta ha sido publicada"
    else
      flash[:notice] = "La respuesta NO ha sido publicada"
    end
    respond_to do |format|
      format.js {}
    end
  end

  def edit
    @answer = current_user.answers.find(params[:id])
  end

  def update
    @answer = current_user.answers.find(params[:id])
    if @answer.save
      flash[:notice] = "La respuesta ha sido actualizada"
    else
      flash[:notice] = "La respuesta NO ha sido actualizada"
    end
    respond_to do |format|
      format.js {}
    end
  end
  
  def vote
    @answer = Answer.find(params[:id])
    @vote = @answer.votes.find_by_user_id(current_user.id)
    if @vote
      if @vote.vote.to_s == params[:vote]
        flash[:notice] = "Ya has votado esta pregunta"
      else
        @vote.update_attributes(:vote => params[:vote])
        flash[:notice] = "Tu voto ha sido actualizado"
      end
    else
      @vote = @answer.votes.build(:user => current_user , :vote => params[:vote])
      if @vote.save
        flash[:notice] = "Tu voto a sido guardado"
      else
        flash[:notice] = "Tu voto NO a sido guardado"
      end
    end
    respond_to do |format|
      format.js {}
    end  
  end
  
  
  def select
    @answer = Answer.find(params[:id])
    if @answer.question.user == current_user
      @prev_selected = @answer.select!
      flash[:notice] = "Tu seleccion ha sido guardada"
    else
      flash[:notice] = "Tu no estas habilitado para seleccionar la respuesta"
    end  
    respond_to do |format|
      format.js {}
    end
  end
  
  private
  
  def load_question
    @question = Question.find(params[:question_id])
  end  
  
end
