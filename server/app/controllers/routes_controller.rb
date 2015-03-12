class RoutesController < ApplicationController
  def coffee_file
    @routes = WhatsForDinner::API.routes
  end
end