class HomeController < ApplicationController
  def index
    @trading_books = Book.where("trading": true) if logged_in?
  end
end
