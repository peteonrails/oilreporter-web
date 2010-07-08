class SessionMeta < ActiveRecord::Base
  belongs_to :report_session
    
  def as_json
    { "#{key}" => "#{value}" }
  end
  
  def self.create_from_params(session, params)
    params.each_pair do |key, val|
      self.create(:report_session_id => session.id, :key => key, :value => val)
    end
  end
end