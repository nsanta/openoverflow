class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question  , :counter_cache => true
  has_many :votes , :as => :voteable
  
  validates_presence_of :user , :question , :body
  
end
