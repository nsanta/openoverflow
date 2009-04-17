class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
  
  validates_presence_of :body , :user , :answer
  
end
