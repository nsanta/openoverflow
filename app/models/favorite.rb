class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  
  validates_presence_of :user , :question
  
end
