class RecipesController < ApplicationController
  def show 
    @recipe = Recipe.find(params[:id])
    if params[:ingredient_id] 
      RecipeIngredient.create!(recipe: @recipe, ingredient: Ingredient.find(params[:ingredient_id].to_i))

    end
  end

  def update 
    
  end

  def create 
    @recipe = Recipe.create(recipe_params)
    redirect_to '/recipes'
  end


  private 
  def recipe_params
    params.permit(:name, :complexity, :genre)
  end




end