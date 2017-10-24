class UsersController < ApplicationController
  before_action :force_json, only: :autocomplete
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.last(12).reverse
  end

  def edit
  end

  def update
  end

  def sync
    @ldap = LdapService.new.users_sync
    flash[:sync_msg] = @ldap
    redirect_to users_path
  end

  def autocomplete
    @users = User.ransack(user_cont: params[:q]).result(distinct: true).limit(10)
  end

  def search
    # Do not display all users if empty search...
    if params[:q] == ''
      redirect_to users_path
      return
    else params[:q]
      @users = User.ransack(user_cont: params[:q]).result(distinct: true)
      render :index
    end
  end

  private

  def force_json
    request.format = :json
  end

  def set_user
    @user = User.find(params[:id])
  end

end
