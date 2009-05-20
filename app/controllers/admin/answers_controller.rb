class Admin::AnswersController < ApplicationController

  before_filter :require_admin

  def index
    @flags = Flag.answers.paginate(:page => params[:page] || 1, :per_page => 20)
  end


  def show
    @answer = Answer.find(params[:id])
    respond_to do |format|
      format.html {} # render show.html.haml
      format.js   { render :layout=>false }
    end
  end


  def ban
    @flag = Flag.find(params[:id])
    @answer = @flag.flaggeable
    @answer.toggle!(:banned)
    if @answer.banned
      flash[:notice] = "La respuesta ha sido restringida"
    else
      flash[:notice] = "La respuesta ha sido aceptada nuevamente"
    end
    respond_to do |format|
      format.html { redirect_to admin_answers_path }
      format.js   {}
    end
  end


  def destroy
    @flag = Flag.answers.find(params[:id])
    @flag.destroy
    flash[:notice] = "La reportacion ha sido eliminada"
    redirect_to admin_answers_path
  end

end
