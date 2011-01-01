class AddNameUniquenssIndex < ActiveRecord::Migration
  def self.up
    add_index :breweries, :name, :unique => true
  end

  def self.down
    remove_index :breweries, :name
  end
end
