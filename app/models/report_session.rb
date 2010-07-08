class ReportSession < ActiveRecord::Base
  has_many :reports
  has_many :session_metas
  
  def to_json
    fields = [:id]

    hash = self.attributes.symbolize_keys.inject({}) do |a, (k, v)|
      fields.include?(k) ? a.merge(k => v) : a
    end
    
    unless self.session_metas.empty?
      hash.merge!(:meta => self.session_metas.collect {|x| { x.key => x.value }})
    end

    hash
  end
end