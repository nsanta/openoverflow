namespace :maintenance do
  namespace :users do
    desc "update badges adquired by users"
    task :badges => :environment do
      Badge.maintenance
    end
  end
end
