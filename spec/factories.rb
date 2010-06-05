require 'factory_girl'

Factory.sequence :post_title do |n|
  "Post Title #{n}"
end

Factory.define :post do |f|
  f.title {Factory.next(:post_title)} 
  f.body 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam laoreet tempus purus, ut venenatis turpis cursus at. Mauris quis mauris odio, in volutpat mi. Nam rutrum justo ac mauris eleifend gravida. Fusce a iaculis sem. Suspendisse dictum ornare tortor, adipiscing imperdiet orci scelerisque et. Integer a orci sit amet sapien accumsan tincidunt a sed dui. Etiam tincidunt sagittis risus, fermentum suscipit tortor dapibus sit amet. Suspendisse mattis interdum pulvinar. Cras sed mi et ipsum elementum condimentum id et velit. Nulla facilisi. Proin sit amet lacus et eros elementum rhoncus sit amet faucibus enim. Ut tincidunt pharetra neque eget lacinia. Nunc ipsum velit, placerat id dignissim vitae, dignissim nec est. Vestibulum sed sagittis lacus. Proin massa lacus, egestas sit amet euismod eget, tincidunt a mauris. Vestibulum id nibh ligula, ut placerat mauris. Nullam lorem elit, adipiscing consectetur fringilla sed, porta et est. Aenean quis arcu ac ante cursus accumsan. Nullam sed urna id lorem dapibus dictum non non tortor. Mauris vitae justo mauris.'
  f.excerpt 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam laoreet tempus purus, ut venenatis turpis cursus at. Mauris quis mauris odio, in volutpat mi. Nam rutrum justo ac mauris eleifend gravida.'
  f.published_on {2.days.ago}
  f.draft false
end

Factory.sequence :login do |n|
  "login#{n}"
end

Factory.sequence :email do |n|
  "user-#{n}@oilreporter.org"
end

Factory.define :user do |f|
  f.login {Factory.next(:login)}
  f.email {Factory.next(:email)}
  f.password 'password'
  f.password_confirmation 'password'
end

Factory.sequence :blog_name do |n|
  "blog#{n}"
end

Factory.define :blog do |f|
  f.name {Factory.next(:blog_name)}
end