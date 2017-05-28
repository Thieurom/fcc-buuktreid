ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper

  # Return true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a particular user.
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # Log out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end


class ActionDispatch::IntegrationTest

  # Log in as a particular user.
  def log_in_as(user, password: "password")
    post login_url, params: { session: { username: user.username,
                                         password: password } }
  end
end
