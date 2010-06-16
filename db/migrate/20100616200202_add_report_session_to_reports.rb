class AddReportSessionToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :report_session_id, :integer
  end

  def self.down
    remove_column :reports, :report_session_id
  end
end
