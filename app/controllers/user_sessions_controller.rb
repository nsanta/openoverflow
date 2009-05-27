class UserSessionsController < ApplicationController
  
  
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :require_no_user , :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  skip_after_filter :store_location

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t('flash.notice.session.create.valid')
      redirect_back_or_default questions_path
    else
      flash[:notice] = t('flash.notice.session.create.invalid')
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t('flash.notice.session.destroy.valid')
    redirect_back_or_default new_user_session_url
  end
  
end

