class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_index_url
    end
  end

  def about
  end

  def contact
  end

  def sign_in

  end
  def maintenance
  end
end
