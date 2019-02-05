require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'recipe'
require_relative 'cookbook'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @recipes = Cookbook.new('recipes.csv').all
  erb :index
end

get '/new' do
  erb :new
end

get "/recipes" do
  @recipes = params["recipe"]
  @recipes = read_recipes
  erb :index
end

post "/recipes" do
  name = params["name"]
  description = params["description"]
  preptime = params["preptime"]
  difficulty = params["difficulty"]
  recipe = Recipe.new(name, description, preptime, difficulty)
  Cookbook.new('recipes.csv').add_recipe(recipe)
  "Added!"
  redirect '/'
end

get '/delete/:index' do
  index = params[:index].to_i
  Cookbook.new('recipes.csv').remove_recipe(index)
  redirect '/'
end
