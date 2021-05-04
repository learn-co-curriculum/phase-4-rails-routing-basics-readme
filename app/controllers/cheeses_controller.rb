class CheesesController < ApplicationController

  def index
    # model
    cheeses = Cheese.order(price: :desc)
    # view
    render json: cheeses
  end

end
