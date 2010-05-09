class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string   :description
      t.integer  :oil
      t.integer  :smell
      t.string   :media_file_name
      t.string   :media_content_type
      t.integer  :media_file_size
      t.datetime :media_updated_at
      t.float    :latitude
      t.float    :longitude
      t.boolean  :respond, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
