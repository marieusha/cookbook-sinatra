require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    load_csv(csv_file_path)
    @csv_file_path = csv_file_path
  end

  def add_recipe(recipe)
    @recipes << recipe
    store_csv(@csv_file_path)
  end

  def all
    @recipes
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    store_csv(@csv_file_path)
  end

  def update
    store_csv(@csv_file_path)
  end

  def load_csv(csv_file_path)
    CSV.foreach(csv_file_path) do |row|
      @done if row[4] == false
        @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def store_csv(csv_file_path)
    CSV.open(csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.preptime, recipe.difficulty, recipe.done?]
      end
    end
  end
end

# Cookbook.new('recipes.csv').remove_recipe(0)


