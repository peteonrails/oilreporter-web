class DevelopersPurposeToText < ActiveRecord::Migration
  def self.up
    change_column :developers, :purpose, :text
  end

  def self.down
    change_column :developers, :purpose, :string
  end
end
