class AddDeviceIdToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :device_id, :string
  end

  def self.down
    remove_column :reports, :device_id
  end
end
