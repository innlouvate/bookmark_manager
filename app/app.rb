ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'models/link.rb'
require_relative 'models/tag.rb'
require_relative 'models/user.rb'
require_relative 'data_mapper_setup.rb'
require 'sinatra/flash'
require 'tilt/erb'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash



  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect '/users/new'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect('/links')
    else
      flash.now[:error] = "Password and confirmation password do not match"
      erb :'/users/new'
    end
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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
