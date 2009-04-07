class Question < ActiveRecord::Base

  acts_as_taggable_on :tags

  belongs_to :user
  
  validates_presence_of :title , :body , :user
  
end
