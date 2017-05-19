class BooksController < ApplicationController

  before_action :logged_in_user

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

  private

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
          description = volume_info['description'] ? volume_info['description'] : "No information"
          cover_image_link = volume_info['imageLinks'] ? volume_info['imageLinks']['thumbnail'] : ""

          {'title' => title,
           'author' => author,
           'description' => description,
           'cover_image_link' => cover_image_link}
        end
      else
      end
    end

    # Before filters

    # Confirm a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url
      end
    end
end
