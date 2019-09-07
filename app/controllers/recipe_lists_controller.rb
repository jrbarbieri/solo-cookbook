class RecipeListsController < ApplicationController
  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.create(params.require(:recipe_list).permit(:name))
    redirect_to @recipe_list
    flash[:notice] = 'Lista criada com sucesso!'
  end

  def show 
    @recipe_list = RecipeList.find(params[:id])
  end
end