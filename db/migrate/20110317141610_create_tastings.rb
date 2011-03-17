class CreateTastings < ActiveRecord::Migration
  def self.up
    create_table :tastings do |t|
      t.integer :beer_id
      t.integer :taster_id
      t.integer :rating
      t.string :comments
      t.date :tasted_on

      t.timestamps
    end
  end

  def self.down
    drop_table :tastings
  end
end
