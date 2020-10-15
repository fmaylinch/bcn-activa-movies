require 'sinatra'
require 'sinatra/activerecord'

require_relative './db/models'
require_relative './model/director'


# routes

get '/' do
  @movies = Movie.all
  erb :index
end

post '/' do

  id = params["id"]
  movie = Movie.find_by(id: id)
  movie.name = params["name"]
  movie.director = params["director"]
  movie.rating = params["rating"].to_i
  movie.save

  redirect '/'
end

get '/movies/:id' do
  id = params[:id]
  @movie = Movie.find_by(id: id)
  erb :movie
end

directors_store = DirectorsStore.new

get '/directors' do
  @directors = directors_store.all
  erb :directors
end
