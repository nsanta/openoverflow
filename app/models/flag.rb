class Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :flaggeable , :polymorphic => true
  
  validates_presence_of :user , :flaggeable , :body  
  
  after_create {|record| record.add_points(5)}
  
end
