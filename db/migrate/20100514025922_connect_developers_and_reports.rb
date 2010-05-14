class ConnectDevelopersAndReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :developer_id, :integer
  end

  def self.down
    remove_column :reports, :developer_id
  end
end
