class UsersController < ApplicationController

  def index
    respond_to do |format|
      if params[:term]
        @users = User.search_by_name(params[:term])
      else
        @users = User.all
      end
      format.json
      format.html
    end
  end

end
