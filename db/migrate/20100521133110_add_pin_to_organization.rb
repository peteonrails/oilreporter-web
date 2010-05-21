class AddPinToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :pin, :integer
  end

  def self.down
    remove_column :organizations, :pin
  end
end
