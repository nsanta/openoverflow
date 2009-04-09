class Vote < ActiveRecord::Base
  VOTE_RANGE = [-1 , 1]

  belongs_to :user
  
  belongs_to :voteable , :polymorphic => true
  
  
  validates_presence_of :vote , :voteable , :user
  validates_inclusion_of :vote, :in => VOTE_RANGE
  validates_uniqueness_of :user_id  , :scope => [:voteable_id , :voteable_type]
  
end
