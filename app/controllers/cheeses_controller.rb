class CheesesController < ApplicationController
    def index
        cheese = Cheese.first.order
        render json: cheese
    end
end
