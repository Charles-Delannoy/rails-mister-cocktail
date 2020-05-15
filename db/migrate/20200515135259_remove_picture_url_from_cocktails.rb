class RemovePictureUrlFromCocktails < ActiveRecord::Migration[6.0]
  def change
    remove_column :cocktails, :picture_url
  end
end
