class AddWithinOilSpillToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :within_oil_spill, :boolean, :default => false
  end

  def self.down
    remove_column :reports, :within_oil_spill
  end
end
