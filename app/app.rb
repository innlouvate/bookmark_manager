require 'sinatra/base'
require_relative 'models/link.rb'
require_relative 'models/tag.rb'
require_relative 'models/user.rb'
require_relative 'data_mapper_setup.rb'
require 'tilt/erb'
# require_relative 'helper'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  # include Helpers

  ENV['RACK_ENV'] ||= 'development'

  # helpers do
  #   def current_user
  #     @current_user ||= User.get(session[:user_id])
  #   end
  # end

  get '/' do
    redirect '/users/new'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
    session[:user_id] = user.id
    params[:password] == params[:password_confirmation] ? redirect('/links') : redirect('/users/failed')
  end

  get '/users/failed' do
    erb :'users/failed'
  end

  get '/links' do
    @list = Link.all
    @user = current_user
    erb(:links)
  end

  get '/links/new' do
    erb(:new_link)
  end

  post '/links' do
    @link = Link.create(:title => params[:title], :url => params[:url])
    params[:tag].split(",").map(&:strip).each do |tag|
          @link.tags << Tag.first_or_create(tag: tag)
      end
      @link.save
    redirect '/links'
  end

  post '/tags' do
    @search = params[:search]
    redirect "/tags/#{@search}"
  end

  get '/tags/:search' do
    # check it's a tag
    @user = current_user
    tag = Tag.first(tag: params[:search])
    @list = tag ? tag.links : []
    erb(:links)
  end

  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
