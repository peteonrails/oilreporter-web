class ConvertReportOrganizationToInteger < ActiveRecord::Migration
  def self.up
    # we can do this because right now (5/26/10) there are no reports with organization ids
    remove_column :reports, :organization_id
    add_column :reports, :organization_id, :integer
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
