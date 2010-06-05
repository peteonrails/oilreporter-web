class Month
  class Error < StandardError; end
  
  NAMES = Date::MONTHNAMES
  ABBR_NAMES = Date::ABBR_MONTHNAMES
  
  attr_accessor :year, :month
  
  def initialize(date_or_year, month=nil)
    case date_or_year
      when Date, Time, DateTime
        self.month = date_or_year.month
        self.year = date_or_year.year
      else
        self.year = date_or_year
        self.month = month || 1
    end
    raise Error, "Month must be between 1 and 12, you entered #{self.month.inspect}." unless (1..12).include?(self.month)
  end
  
  def < (other_month)
    return false if year > other_month.year
    return true if year < other_month.year 
    return true if month < other_month.month
    return false
  end
  
  def > (other_month)
    return false if year < other_month.year
    return true if year > other_month.year 
    return true if month > other_month.month
    return false
  end
  
  def name
    NAMES[month]
  end
  
  def to_s
    "#{name} #{year}"
  end
  
  def inspect
    "#<Month year=#{year} month=#{month}>"
  end
  
  def == (other_month)
    year == other_month.year && month == other_month.month
  end
  
  def <=> (other_month)
    return -1 if self < other_month
    return 0 if self == other_month
    return 1 if self > other_month
  end
  
  def succ
    Month.new((month == 12 ? year + 1 : year), (month % 12) + 1)
  end
end