class HomeController < ApplicationController
  layout "application_home"

  def index
    @carousels = Carousel.all

    @showrooms = Showroom.all
  end

end
