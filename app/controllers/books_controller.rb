class BooksController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user, only: [:open_trading, :cancel_trading, :destroy]
  before_action :get_book, only: [:open_trading, :cancel_trading, :accept_trading, :destroy]


  GOOGLE_BOOKS_API_BASE_URL = ENV['GOOGLE_BOOKS_API_BASE_URL']
  GOOGLE_BOOKS_API_KEY = ENV['GOOGLE_BOOKS_API_KEY']

  def new
    respond_to do |format|
      format.html
      format.js do
        @search_results = parse_result(search params['q'])
      end
    end
  end

  def create
    @book = current_user.books.build(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to root_url }
        format.js { head :created }
      else
        format.html { redirect_to root_url }
        format.js { head :internal_server_error }
      end
    end
  end

  def open_trading
    @book.update_attribute(:trading, true)
    responde_to_trading_request
  end

  def cancel_trading
    @book.update_attribute(:trading, false)
    responde_to_trading_request
  end

  def accept_trading
    @book.update_attributes(user_id: current_user.id, trading: false)
    responde_to_trading_request
  end

  def destroy
    @book.destroy
    responde_to_trading_request
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :description, :cover_image_link)
    end

    def get_book
      @book = Book.find_by(id: params[:id])
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      return redirect_to root_url if @book.nil?
    end

    def responde_to_trading_request
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js { head :no_content }
      end
    end

    def search(term)
      query_url = GOOGLE_BOOKS_API_BASE_URL + "volumes?q=#{term}&maxResults=40&key=#{GOOGLE_BOOKS_API_KEY}"
      response = HTTParty.get query_url
      data = JSON.parse response.body
    end

    def parse_result(data)
      if data['totalItems'] > 0
        items = data['items']
        
        books = items.map do |item|
          volume_info = item['volumeInfo']

          title = volume_info['title']
          author = volume_info['authors'] ? volume_info['authors'].join(', ') : "No information"
          description = volume_info['description'] ? volume_info['description'] : ""
          cover_image_link = volume_info['imageLinks'] ? volume_info['imageLinks']['thumbnail'] : ""

          {'title' => title,
           'author' => author,
           'description' => description,
           'cover_image_link' => cover_image_link}
        end
      else
      end
    end
end
