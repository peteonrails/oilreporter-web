server "traduiapp.com", :app, :web, :db, :primary => true
set :local_config, ['config/database.yml']

namespace :deploy do
  
  # desc "Notify Hoptoad of Deploy"
  # task :after_symlink do
  #  run  "cd #{release_path}; rake hoptoad:deploy TO=staging RAILS_ENV=production"
  # end
  
end