class UsersController < ApplicationController

  def index
    byebug
    if params[:term]
      @users = User.search_by_name(params[:term])
    else
      @users = User.all
    end
  end

end
