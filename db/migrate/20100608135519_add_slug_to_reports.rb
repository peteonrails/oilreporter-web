class AddSlugToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :slug, :string
  end

  def self.down
    remove_column :reports, :slug, :string
  end
end
