class Question < ActiveRecord::Base

  acts_as_taggable_on :tags

  belongs_to :user
  has_many :votes , :as => :voteable
  has_many :answers
  
  validates_presence_of :title , :body , :user
  validates_length_of :title , :within => 3..40
  
  
end
