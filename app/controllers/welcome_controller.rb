class WelcomeController < ApplicationController
  def index
    if signed_in?
      redirect_to current_user
    else
      render 'welcome/index'
    end
  end
end
