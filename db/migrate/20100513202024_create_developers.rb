class CreateDevelopers < ActiveRecord::Migration
  def self.up
    create_table :developers do |t|
      t.string :name
      t.string :email
      t.string :website
      t.string :purpose
      t.string :api_key 

      t.timestamps
    end
  end

  def self.down
    drop_table :developers
  end
end
