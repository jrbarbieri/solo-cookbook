class RecipesController < ApplicationController
  def index
  	@recipes = Recipe.all
  end

  def show
  	@recipes = Recipe.find(params[:id])
  end

  def new
  	@recipes = Recipe.new
  end

  def create
  	@recipes = Recipe.create(set_params)
  	redirect_to @recipes
  end

  def edit
    @recipes = Recipe.find(params[:id])
  end

  def update
    @recipes = Recipe.update(set_params)
    redirect_to @recipes
  end

  private

  def set_params
  	params.require(:recipe).permit(:tittle, :recipe_type, :cuisine,
  								   :difficulty, :cook_time, :ingredients, :cook_method)
  end
end