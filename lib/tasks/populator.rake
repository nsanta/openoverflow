namespace :db do
  namespace :populate do
    desc "create admin user"
    task :create_admin => :environment do
      user = User.create(:login => 'admin' , :email => 'nicolas55ar@gmail.com' , :password => '0p3n0v3rfl0w' , :password_confirmation => '0p3n0v3rfl0w')
      user.admin = true
      user.save
    end
    desc "create 100 questions"
    task :questions => :environment do
      require 'populator'
      require 'faker'
      @user = User.last
      100.times do
        Question.create(:title =>   Populator.words(1..6).titleize, 
                        :body => Populator.sentences(2..10), 
                        :tag_list => Populator.words(1..6).titleize.gsub(' ' , ','), 
                        :user => @user)
      end
    end
    task :badges => :environment do
      Badge.delete_all
      badges_file = YAML.load(File.open(File.join(RAILS_ROOT , 'db' , 'badges.yml')).read)
      badges_file.each do |level,badges|
        badges.each do |badge , content|
          Badge.create!(:title => badge , 
                        :description => content["desc"] , 
                        :image_url => content["img"] ,
                        :level => level,
                        :model => content["model"],
                        :command => content["command"])
        end
      end
    end
    
  end
end
