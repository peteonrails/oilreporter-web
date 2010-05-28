require 'geometry'
require 'point'

class OilSpill
  include Singleton
  include Geometry

  # Starts at Harlingen, TX and goes clockwise around the Gulf of Mexico
  # http://maps.google.com/maps/ms?ie=UTF8&hl=en&msa=0&msid=117921590065269176309.000487ab67ae95c150340
  BOUNDS = [
    Point.new(:y => 26.169901, :x => -97.738037),
    Point.new(:y => 29.281288, :x => -98.155518),
    Point.new(:y => 30.916050, :x => -92.530518),
    Point.new(:y => 30.916050, :x => -92.530518),
    Point.new(:y => 31.123184, :x => -86.004639),
    Point.new(:y => 30.802877, :x => -81.016846),
    Point.new(:y => 25.656052, :x => -79.149170),
    Point.new(:y => 23.845650, :x => -81.408691),
    Point.new(:y => 21.794868, :x => -98.616943)
  ] unless const_defined?('BOUNDS')

  def contains?(latitude, longitude)
    return false if latitude == 0 or longitude == 0
    contains_point?(BOUNDS, Point.new(:x => longitude, :y => latitude))
  end

end
