class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :email
      t.string :company
      t.string :website
      t.string :twitter
      t.string :blog
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.text :bio
      t.boolean :admin, :default => false
      t.boolean :listed
      t.integer :position
      t.integer :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end