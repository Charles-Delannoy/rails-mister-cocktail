class CocktailsController < ApplicationController
  def home
  end

  def index
    @cocktails = Cocktail.order(:name)
  end

  def show
    @cocktail = Cocktail.find(params['id'])
    @doses = Dose.where(cocktail_id: @cocktail.id)
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.save ? (redirect_to cocktail_path(@cocktail)) : (render :new)
  end

  def new
    @cocktail = Cocktail.new
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :picture_url, :photo)
  end
end
