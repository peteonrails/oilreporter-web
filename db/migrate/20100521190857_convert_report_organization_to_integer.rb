class ConvertReportOrganizationToInteger < ActiveRecord::Migration
  def self.up
    change_column :reports, :organization_id, :integer
  end

  def self.down
    change_column :reports, :organization_id, :string
  end
end
