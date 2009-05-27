class UsersController < ApplicationController

  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :require_no_user, :only => [:new, :create]
  skip_after_filter :store_location , :except => [:show , :edit]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    # By default I think it's BETTER to make it NOT an ADMIN USER!!!
    @user.admin = false
    if @user.save
      flash[:notice] = t('flash.notice.user.create.valid')
      redirect_back_or_default root_path
    else
      flash[:notice] = t('flash.notice.user.create.invalid')
      render :action => :new
    end
  end


  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
  end


  def edit
    @user = current_user
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = t('flash.notice.user.update.valid')
      redirect_to account_url
    else
      flash[:notice] = t('flash.notice.user.update.invalid')
      render :action => :edit
    end
  end

end
