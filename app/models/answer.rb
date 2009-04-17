class Answer < ActiveRecord::Base
  
  
  belongs_to :user
  belongs_to :question  , :counter_cache => true
  has_many :votes , :as => :voteable
  has_many :comments
  
  validates_presence_of :user , :question , :body
  
  
  
  
  # == InstanceMethods
  
  def select!
    if prev_selected = Answer.first(:conditions => {:question_id => self.question_id , :selected => true})
      prev_selected.toggle!(:selected)
    end
    self.toggle!(:selected)
    prev_selected
  end
  
  
  
end
