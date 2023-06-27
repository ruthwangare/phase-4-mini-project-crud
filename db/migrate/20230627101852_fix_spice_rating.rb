class FixSpiceRating < ActiveRecord::Migration[6.1]
  def change
    rename_column :spices, :ratinf, :rating
  end
end
