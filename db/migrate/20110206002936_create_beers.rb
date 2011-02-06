class CreateBeers < ActiveRecord::Migration
  def self.up
    create_table :beers do |t|
      t.integer :brewery_id
      t.string :style
      t.string :name
      t.float :abv
      t.string :description

      t.timestamps
    end
    
    add_index :beers, :brewery_id
  end

  def self.down
    drop_table :beers
  end
end
