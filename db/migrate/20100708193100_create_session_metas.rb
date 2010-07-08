class CreateSessionMetas < ActiveRecord::Migration
  def self.up
    create_table :session_metas do |t|
      t.integer :report_session_id
      t.string :key
      t.string :value
    end
  end

  def self.down
    drop_table :session_metas
  end
end
