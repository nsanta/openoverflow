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

  belongs_to :user , :counter_cache => :total_questions
  has_many :votes , :as => :voteable
  has_many :answers
  
  validates_presence_of :title , :body , :user
  validates_length_of :title , :within => 3..40
  
  #== Callbacks
  #after_create {|record| record.add_points(20)}
  # before_save {|record| record.parse_source_code_in_body}
 
  def unanswered (page = 1)
    self.paginate(:conditions => "answers_count > 0" , :order => 'created_at DESC' , :page => page , :per_page => 20)
  end
  
  
  
  
  def add_points(points = 1)
    self.user.total_points += points
    self.user.save
  end
  
  private
  
#  def parse_source_code_in_body
#    if self.body.changed? || self.new_record?
#      doc = Nokogiri::HTML.parse(self.body)
#      doc.search('pre').each do |pre|
#        source_code_type = pre['class']
#        output = `source-highlight --src-lang #{source_code_type} --out-format html < "#{pre}"`
#      end
#      self.parse_body = 
#    end
#  end
  
  
end
