class Admin::UsersController < ApplicationController

  before_filter :require_admin

end
