class AddMoreFieldsToReports < ActiveRecord::Migration
  def self.up
    remove_column :reports, :respond
    remove_column :reports, :smell
    add_column :reports, :wetlands, :integer
    add_column :reports, :wildlife, :string
  end

  def self.down
    add_column :reports, :respond, :boolean
    add_column :reports, :smell, :integer
    remove_column :reports, :wetlands
    remove_column :reports, :wildlife    
  end
end
