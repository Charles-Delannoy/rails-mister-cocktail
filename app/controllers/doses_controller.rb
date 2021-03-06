class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params['cocktail_id'])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params['cocktail_id'])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    @dose.ingredient = Ingredient.find(params['dose']['ingredient_id'])
    @dose.save ? (redirect_to cocktail_path(@cocktail)) : (render :new)
  end

  def destroy
    @dose = Dose.find(params['id'])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :cocktail, :ingredient)
  end
end
