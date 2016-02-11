require_relative 'models/user'

module Helpers do
  def self.current_user
    current_user ||= User.get(session[:user_id])
  end
end
