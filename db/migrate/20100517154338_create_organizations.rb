class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.string :contact_person
      t.string :email
      t.string :website
      t.text :purpose
      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
