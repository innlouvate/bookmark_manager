ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require_relative 'models/link'


class Bookmark < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  use Rack::MethodOverride

  get '/' do
    redirect to('/users/sign_in')
  end

  get '/link' do
    @link = Link.all
    erb :index
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/link' do
    link = Link.create(url: params[:url], bookmark_name: params[:bookmark_name])
    params[:tag].split.each do |tag|
      link.tag << Tag.create(tag: tag)
    end
    link.save
    redirect to ('/link')
  end

  get '/link/tag/:tag' do
    tag = Tag.first(tag: params[:tag])
    @link = tag ? tag.link : []
    erb :index
  end

  get '/sign-up' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email], password: params[:password], :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/link'
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/link')
    else
      flash.now[:error] = 'Email or password is incorrect'
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'Come back soon'
    redirect to '/link'
  end

  helpers do
    def current_user
      @current_user ||=User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
