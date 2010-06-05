User.seed(:login) do |s|
  s.login = 'intridea'
  s.company = 'Intridea'
  s.email = 'oilreporter@intridea.com'
  s.password = 'oilreporter+intridea'
  s.password_confirmation = 'oilreporter+intridea'
  s.admin = true
end

User.seed(:login) do |s|
  s.login = 'crisiscommons'
  s.company = 'Crisis Commons'
  s.email = 'heather@crisiscommons.org'
  s.password = 'oilreporter+crisiscommons'
  s.password_confirmation = 'oilreporter+crisiscommons'
  s.admin = true
end

User.seed(:login) do |s|
  s.login = 'appcelerator'
  s.company = 'Appcelerator'
  s.email = 'sschwarzhoff@appcelerator.com'
  s.password = 'oilreporter+appcelerator'
  s.password_confirmation = 'oilreporter+appcelerator'
  s.admin = true
end