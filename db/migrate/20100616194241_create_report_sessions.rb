class CreateReportSessions < ActiveRecord::Migration
  def self.up
    create_table :report_sessions do |t|
    end
  end

  def self.down
    drop_table :report_sessions
  end
end
