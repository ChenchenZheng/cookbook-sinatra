require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"

csv_file = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file)

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :create
end

post '/recipes' do
  name = params['Name']
  description = params['Description']
  rating = params['Rating']
  prep_time = params['Preptime']
  done = params['Done']
  recipe = Recipe.new(name, description, rating, prep_time, done)
  cookbook.add_recipe(recipe)
  @recipes = cookbook.all
  erb :index
end

delete '/recipe/:index' do
  index = params[:index].to_i
  cookbook.remove_recipe(index)
  redirect to '/'
  erb :index
end
