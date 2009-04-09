class Question < ActiveRecord::Base

  acts_as_commentable
  acts_as_taggable_on :tags

  belongs_to :user
  has_many :votes , :as => :voteable
  
  
  validates_presence_of :title , :body , :user
  
end
