class RecipesController < ApplicationController

  before_action :set_params_id, only: %i[show edit update]
  before_action :load_recipe_type, only: %i[new create edit update]
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipes = Recipe.new
  end

  def show; end

  def create
    @recipes = Recipe.create(set_params)
    @recipes.user = current_user
    
    if @recipes.save
      flash[:notice] = 'Receita criada com sucesso!'
      redirect_to @recipes
    else
      flash.now[:alert] = 'Receita não cadastrada.'
      render :new
    end
  end

  def edit
    redirect_to root_path if !@recipes.owner? current_user
  end

  def update
    if @recipes.update(set_params)
      redirect_to @recipes
    else
      flash.now[:alert] = 'Não foi possível salvar a receita'
      render :edit
    end
  end

  def search
    @recipes = Recipe.where('tittle LIKE ?', "%#{params[:name]}%")
    if @recipes.empty?
      flash.now[:alert] = 'Nenhuma receita encontrada.'      
    end
  end

  def my_recipes
    @recipes = Recipe.where("user_id = #{params[:id]}")
  end

  private

  def set_params
  	params.require(:recipe).permit(:tittle, :recipe_type_id, :cuisine,
  								   :difficulty, :cook_time, :ingredients, :cook_method, :user)
  end

  def set_params_id
    @recipes = Recipe.find(params[:id])
  end

  def load_recipe_type
    @recipe_types = RecipeType.all
  end

end