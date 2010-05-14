class AddVolunteerToDevelopers < ActiveRecord::Migration
  def self.up
    add_column :developers, :volunteer, :boolean, :default => false
  end

  def self.down
    remove_column :developers, :volunteer
  end
end
