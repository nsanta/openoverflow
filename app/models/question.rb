class Question < ActiveRecord::Base

  acts_as_tsearch :fields => ['title','body']

  acts_as_taggable_on :tags

  belongs_to :user , :counter_cache => :total_questions
  has_many :votes , :as => :voteable
  has_many :answers
  
  validates_presence_of :title , :body , :user
  validates_length_of :title , :within => 3..40
  
 
  def unanswered (page = 1)
    self.paginate(:conditions => "answers_count > 0" , :order => 'created_at DESC' , :page => page , :per_page => 20)
  end
  
end
