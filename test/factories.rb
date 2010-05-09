Factory.define :new_orleans, :class => Report do |s|
  s.description 'Oily seagulls, dead fish washed up on shore'
  s.oil 9
  s.wetlands 7
  s.wildlife "No wildlife"
  s.latitude 29.964639
  s.longitude -90.067763
end

Factory.define :biloxi, :class => Report do |s|
  s.description 'Oily slick on sand'
  s.oil 7
  s.wetlands 5
  s.wildlife "No wildlife"
  s.latitude 30.395569
  s.longitude -88.884866
end

Factory.define :pensacola, :class => Report do |s|
  s.description 'No visible effects'
  s.oil 0
  s.wetlands 0
  s.wildlife "No wildlife"
  s.latitude 30.41241
  s.longitude -87.219086
end
