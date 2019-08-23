class RecipeTypesController < ApplicationController

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))
    if @recipe_type.save
      flash[:notice] = 'Novo tipo de receita cadastrado com sucesso!'
      redirect_to @recipe_type
    else
      flash.now[:alert] = 'Tipo de receita não cadastrado!'
      render :new
    end
  end

  def show
    @recipe_type = RecipeType.find(params[:id])
  end

end