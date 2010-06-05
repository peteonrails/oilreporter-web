class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.string :slug
      t.string :atomid
      t.string :body_format
      t.string :cached_tag_list
      t.text :excerpt
      t.text :body
      t.boolean :draft, :default => true
      t.boolean :featured, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :published_on

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
