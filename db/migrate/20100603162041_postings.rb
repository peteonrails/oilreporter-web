class Postings < ActiveRecord::Migration
  def self.up
    create_table :postings do |t|
      t.integer :blog_id
      t.integer :post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :postings
  end
end
