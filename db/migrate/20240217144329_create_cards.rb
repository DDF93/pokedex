class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :rarity
      t.string :image_url
      t.float :price
      t.timestamps
    end
  end
end
