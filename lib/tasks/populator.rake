namespace :db do
  namespace :populator do
    desc "create admin user"
    task :create_admin => :environment do
      user = User.create(:login => 'admin' , :email => 'nicolas55ar@gmail.com' , :password => '0p3n0v3rfl0w' , :password_confirmation => '0p3n0v3rfl0w')
      user.admin = true
      user.save
    end
  end
end
