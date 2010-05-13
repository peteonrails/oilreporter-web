class AddOrganizationIdToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :organization_id, :string
  end

  def self.down
    remove_column :reports, :organization_id
  end
end
