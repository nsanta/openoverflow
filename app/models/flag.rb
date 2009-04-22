class Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :flaggeable , :polymorphic => true
  
  validates_presence_of :user , :flaggeable , :body  
end
