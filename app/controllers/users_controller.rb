class UsersController < ApplicationController
  before_action :force_json, only: :autocomplete

  def index
    @users = User.last(10).reverse
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
    if params[:q]
      @users = User.ransack(user_cont: params[:q]).result(distinct: true)
    else
      @users = User.all
    end
    render :index
  end

  private

  def force_json
    request.format = :json
  end

end
