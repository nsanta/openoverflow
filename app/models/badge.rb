class Badge < ActiveRecord::Base

  has_many :user_badges
  has_many :users , :through => :user_badges

  
 
  validates_presence_of :title , :description , :level, :image_url
 
 
  named_scope :by_users , :conditions => "model = 'user'"
  named_scope :by_questions , :conditions => "model = 'question'"
 
 
  def self.maintenance
      user_badges = self.by_users
      users = User.all(:conditions => "updated_at > '#{1.week.ago.to_s(:db)}'" , :include => [:badges])
      users.each do |user|
        left_badges = ( user_badges - user.badges)
        left_badges.each do |badge|
          puts "checking for #{user.login}: #{badge.model}.#{badge.command}"
          puts eval("#{badge.model}.#{badge.command}")
          if eval("#{badge.model}.#{badge.command}")
            user.badges << badge 
            user.save
          end  
        end
      end
      questions = Question.all(:conditions => "updated_at > '#{1.week.ago.to_s(:db)}'")
      question_badges = self.by_questions
      questions.each do |question|
        left_badges = ( question_badges - u.badges)
        left_badges.each do |badge|
           question.user.badges << badge  if eval("#{badge.model}.#{badge.command}")
           user.save
        end
      end
  end
 
end
