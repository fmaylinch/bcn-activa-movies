require 'sinatra'
require 'sinatra/activerecord'

require_relative './db/models'


# routes

get '/' do
  @movies = Movie.all
  erb :index
end
