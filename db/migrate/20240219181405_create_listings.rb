class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.references :card, null: false, foreign_key: true
      t.references :seller, polymorphic: true, null: false

      t.timestamps
    end
  end
end
