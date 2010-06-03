class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :reports, [:latitude, :longitude, :device_id], :name => "index_reports", :unique => true
  end

  def self.down
    remove_index :reports, [:latitude, :longitude, :device_id], :name => "index_reports"
  end
end
