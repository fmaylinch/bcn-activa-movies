require 'sinatra'
require 'sinatra/activerecord'

require_relative './db/models'
require_relative './model/director'


# routes

get '/' do
  @movies = Movie.all
  erb :index
end

directors_store = DirectorsStore.new

get '/directors' do
  @directors = directors_store.all
  erb :directors
end
