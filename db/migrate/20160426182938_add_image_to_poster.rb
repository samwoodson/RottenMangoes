class AddImageToPoster < ActiveRecord::Migration
  def change
    add_column :movies, :image, :string
  end
end
