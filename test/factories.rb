Factory.define :dilbert, :class => Developer do |s|
  s.name 'Dilbert'
  s.purpose 'An Android-based device'
  s.email 'dilbert@company.com'
  s.volunteer true
end

Factory.define :ratbert, :class => Developer do |s|
  s.name 'Ratbert'
  s.purpose 'To destroy the world'
  s.volunteer false # what did you expect? ;-)
end

Factory.define :shield, :class => Organization do |s|
  s.name 'Shield'
  s.purpose 'Strategic Homeland Intervention, Enforcement and Logistics Division'
  s.contact_person 'Nick Fury'
  s.email 'nick.fury@shield.org'
  s.website 'http://shield.org'
end

Factory.define :super_friends, :class => Organization do |s|
  s.name 'Super Friends'
  s.purpose 'Protect Humanity'
  s.contact_person 'Superman'
  s.email 'superman@superfriends.org'
  s.website 'http://superfriends.org'
end

Factory.define :legion_of_doom, :class => Organization do |s|
  s.name 'Legion of Doom'
  s.purpose 'Evil'
  s.contact_person 'Lex Luthor'
end

Factory.define :new_orleans, :class => Report do |s|
  s.description 'Oily seagulls, dead fish washed up on shore'
  s.oil 9
  s.wetlands 7
  s.wildlife "No wildlife"
  s.latitude 29.964639
  s.longitude -90.067763
  s.developer { |a| a.association(:dilbert) }
end

Factory.define :biloxi, :class => Report do |s|
  s.description 'Oily slick on sand'
  s.oil 7
  s.wetlands 5
  s.wildlife "No wildlife"
  s.latitude 30.395569
  s.longitude -88.884866
  s.developer { |a| a.association(:dilbert) }
end

Factory.define :pensacola, :class => Report do |s|
  s.description 'No visible effects'
  s.oil 0
  s.wetlands 0
  s.wildlife "No wildlife"
  s.latitude 30.41241
  s.longitude -87.219086
  s.developer { |a| a.association(:dilbert) }
end

Factory.define :washington_dc, :class => Report do |s|
  s.description 'No visible effects'
  s.oil 8
  s.wetlands 5
  s.wildlife "Lots of wildlife"
  s.latitude 38.85
  s.longitude -77.04
  s.developer { |a| a.association(:dilbert) }
end

Factory.define :atlanta, :class => Report do |s|
  s.description 'No visible effects'
  s.oil 8
  s.wetlands 5
  s.wildlife "Lots of wildlife"
  s.latitude 33.65
  s.longitude -84.42
  s.developer { |a| a.association(:dilbert) }
end

Factory.define :louisiana, :class => State do |s|
  s.code 'LA'
  s.name 'Louisiana'
end
