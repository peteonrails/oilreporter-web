class AddReportsToStates < ActiveRecord::Migration
  def self.up
    add_column :reports, :state_id, :integer
  end

  def self.down
    remove_column :reports, :state_id
  end
end
