class RecipesController < ApplicationController

  before_action :set_params_id, only: %i[show edit]
  before_action :load_recipe_type, only: %i[new create edit]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipes = Recipe.new
  end

  def show; end

  def create
    @recipes = Recipe.create(set_params)
    if @recipes.save
      flash[:notice] = 'Receita criada com sucesso!'
      redirect_to @recipes
    else
      flash.now[:alert] = 'Receita não cadastrada.'
      render :new
    end
  end

  def edit; end

  def update
    @recipes = Recipe.update(set_params)
    redirect_to @recipes
  end

  private

  def set_params
  	params.require(:recipe).permit(:tittle, :recipe_type_id, :cuisine,
  								   :difficulty, :cook_time, :ingredients, :cook_method)
  end

  def set_params_id
    @recipes = Recipe.find(params[:id])
  end

  def load_recipe_type
    @recipe_types = RecipeType.all
  end

end