class HomeController < ApplicationController
  def index
    @containers = Docker::Container.all(:all => true)
  end
end
