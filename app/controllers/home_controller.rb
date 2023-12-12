class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # this is my splash page
  end
end
