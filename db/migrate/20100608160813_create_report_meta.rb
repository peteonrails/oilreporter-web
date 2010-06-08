class CreateReportMeta < ActiveRecord::Migration
  def self.up
    create_table :report_metas do |t|
      t.integer :report_id
      t.string :key
      t.string :value
    end
  end

  def self.down
    drop_table :report_metas
  end
end
