class HomeController < ApplicationController
  skip_before_filter :require_user
 

  def index
  end

end
