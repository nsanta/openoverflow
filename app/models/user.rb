class User < ActiveRecord::Base

  acts_as_authentic

  has_many :questions

  has_many :question_votes , :class_name => 'Vote' , :conditions => "votes.voteable_type= 'Question'"

end
