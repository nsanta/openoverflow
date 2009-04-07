class QuestionsController < ApplicationController

  skip_before_filter :require_user , :only => [:show, :index]

  def index
    @questions = Question.paginate(:all , :page => params[:page] , :per_page => 10 , :order => 'created_at DESC')
  end

  def new
    @question = Question.new  
  end

  def create
    @question = Question.new(params[:question])
    @question.user = current_user
    if @question.save
      flash[:notice] = 'La pregunta ha sido creada'
      redirect_to questions_path
    else
      flash[:notice] = 'La pregunta NO ha sido creada'
      render 'new'
    end
  end
  
  def show
    @question = Question.find(params[:id])
  end

end
