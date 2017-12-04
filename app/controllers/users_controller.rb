class UsersController < ApplicationController
  before_action :force_json, only: :autocomplete
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.last(12).reverse
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = ENV['DEFAULT_PASSWORD']
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
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

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, user_options_attributes: [:option_id, :id, :value, :_destroy])
  end

end
