# == Schema Information
# Schema version: 20090424001630
#
# Table name: questions
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  body          :text
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  votes_average :integer         default(0)
#  total_views   :integer         default(0)
#  answers_count :integer         default(0)
#  answered      :boolean
#

class Question < ActiveRecord::Base

  acts_as_tsearch :fields => ['title','body']

  acts_as_taggable_on :tags

  # == Relations
  belongs_to :user, :counter_cache => :total_questions
  has_many :votes, :as => :voteable
  has_many :answers
  has_many :favorites
  
  # == Validations
  validates_presence_of :title, :body, :user
  validates_length_of :title, :within => 3..80

  # == Named Scopes
  named_scope :unbanned, :conditions => 'banned = FALSE'
  named_scope :banned,   :conditions => 'banned = TRUE'

  # == Callbacks
  after_create {|record| record.add_points(20)}
  # before_save {|record| record.parse_source_code_in_body}
 
  # == Class Methods
  def self.unanswered (page = 1)
    self.paginate(:conditions => "answers_count = 0", :order => 'created_at DESC', :page => page, :per_page => 20)
  end
  
  def self.hot (page = 1)
    self.paginate(:conditions => "answers_count > 0", 
                  :order => 'DATE(created_at) , total_views DESC', 
                  :page => page, :per_page => 20)
  end

  # == Instance Methods
  
  def add_points(points = 1)
    self.user.total_points ||= 0
    self.user.total_points += points
    self.user.save
  end

  
end
