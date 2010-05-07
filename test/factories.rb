Factory.define :new_orleans, :class => Report do |s|
  s.description 'Oily seagulls, dead fish washed up on shore'
  s.oil 9
  s.smell 7
  s.respond true
  s.latitude 29.964639
  s.longitude -90.067763
end

Factory.define :biloxi, :class => Report do |s|
  s.description 'Oily slick on sand'
  s.oil 7
  s.smell 5
  s.respond true
  s.latitude 30.395569
  s.longitude -88.884866
end

Factory.define :pensacola, :class => Report do |s|
  s.description 'No visible effects'
  s.oil 0
  s.smell 0
  s.respond false
  s.latitude 30.41241
  s.longitude -87.219086
end
