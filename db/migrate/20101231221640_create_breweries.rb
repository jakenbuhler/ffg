class CreateBreweries < ActiveRecord::Migration
  def self.up
    create_table :breweries do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :breweries
  end
end
