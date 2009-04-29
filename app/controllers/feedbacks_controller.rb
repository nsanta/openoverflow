class FeedbacksController < ApplicationController

  skip_before_filter :require_user

  def new
    @feedback = Feedback.new
    respond_to do |format|
      format.html # new.html.erb
      format.js   { render :layout => false }
      format.xml  { render :xml => @feedback }
    end
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if current_user
      @feedback.user = current_user
      @feedback.email = current_user.email
    end
    respond_to do |format|
      if @feedback.save
        flash[:notice] = t('flash.notice.feedback.create.valid')
        format.html { redirect_to(root_path) }
        format.xml  { render :xml => @feedback, :status => :created, :location => @feedback }
      else
        flash[:notice] = t('flash.notice.feedback.create.invalid')
        format.html { render :action => "new" }
        format.xml  { render :xml => @feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

############################################################################
#  Index, Show and Delete Feedbacks should be only available for admin tasks
############################################################################
#  def index
#    @feedbacks = Feedback.all
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @feedbacks }
#    end
#  end

#  def show
#    @feedback = Feedback.find(params[:id])
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @feedback }
#    end
#  end

#  def destroy
#    @feedback = Feedback.find(params[:id])
#    @feedback.destroy
#    respond_to do |format|
#      format.html { redirect_to(feedbacks_url) }
#      format.xml  { head :ok }
#    end
#  end


end
