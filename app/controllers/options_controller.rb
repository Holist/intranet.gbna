class OptionsController < ApplicationController

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(option_params)
    if @option.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def option_params
    params.require(:option).permit(:name)
  end

end
