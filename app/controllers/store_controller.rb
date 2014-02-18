class StoreController < ApplicationController
  include CurrentCart
  include StoreIndexVisitCounter

  before_action :set_cart
  before_action :increment_visit_count, only: [:index]

  def index
    @products = Product.order(:title)
  end
end
