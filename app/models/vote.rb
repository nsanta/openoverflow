class Vote < ActiveRecord::Base
  belongs_to :user
  
  belongs_to :voteable , :polymorphic => true
  
  
  validates_presence_of :vote , :voteable , :user
  validates_uniqueness_of :user_id , 
  
end
