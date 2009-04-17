class User < ActiveRecord::Base

  acts_as_authentic
  
  has_attached_file :avatar , :style => {:small => '30x30>'}  

  has_many :questions
  has_many :question_votes , :class_name => 'Vote' , :conditions => "votes.voteable_type= 'Question'"
  has_many :answers
  has_many :answers_votes , :class_name => 'Vote' , :conditions => "votes.voteable_type= 'Answer'"  
  has_many :comments
end
