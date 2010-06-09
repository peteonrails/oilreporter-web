class AddSlugToStates < ActiveRecord::Migration
  def self.up
    add_column :states, :slug, :string
  end

  def self.down
    remove_column :states, :slug, :string
  end
end
