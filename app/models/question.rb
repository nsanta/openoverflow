class Question < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :title , :body , :user
  
end
