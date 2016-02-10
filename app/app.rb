require 'sinatra/base'
require_relative 'models/link.rb'
require_relative 'models/tag.rb'
require_relative 'data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base

  ENV['RACK_ENV'] ||= 'development'
  # set :environment, :development

  get '/' do
    'Hello BookmarkManager!'
  end

  get '/links' do
    @list = Link.all
    erb(:links)
  end

  get '/links/new' do
    erb(:new_link)
  end

  post '/links' do
    @link = Link.create(:title => params[:title], :url => params[:url])
    @tag = Tag.create(:tag => params[:tag])
    @link.tags << @tag
    @link.save
    redirect '/links'
  end

  post '/tags' do
    @search = params[:search]
    redirect "/tags/#{@search}"
  end

  get '/tags/:search' do
    # check it's a tag
    tag = Tag.first(tag: params[:search])
    @list = tag ? tag.links : []
    erb(:links)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
