class CheesesController < ApplicationController
  def index
    cheeses = Cheese.all.order(:name).limit(2)
    render json: cheeses
  end
end
