# == Schema Information
# Schema version: 20090424001630
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  login               :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  login_count         :integer
#  last_request_at     :datetime
#  last_login_at       :datetime
#  current_login_at    :datetime
#  last_login_ip       :string(255)
#  current_login_ip    :string(255)
#  email               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  total_votes         :integer         default(0)
#  total_answers       :integer         default(0)
#  total_questions     :integer         default(0)
#  total_tags          :integer         default(0)
#  admin               :boolean         default(TRUE)
#  total_points        :integer         default(1)
#

class User < ActiveRecord::Base

  acts_as_authentic

  # == Relations
  has_attached_file :avatar, :style => {:small => '42x42#'}  

  has_many :questions
  has_many :question_votes,:class_name => 'Vote', :conditions => "votes.voteable_type= 'Question'"
  has_many :answers
  has_many :answers_votes, :class_name => 'Vote', :conditions => "votes.voteable_type= 'Answer'"
  has_many :comments
  has_many :favorites
  has_many :favorite_questions , :through => :favorites , :source => 'question'
  has_many :user_badges
  has_many :badges , :through => :user_badges , :uniq => true
  has_many :flags
  # == Validations
  validates_numericality_of :total_points, :greater_or_equal_than => 0
 
  #== Callbacks
  before_create :set_defaults


  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end  

  protected
  
  def set_defaults
    self.total_votes_down = self.total_votes_up = self.total_points = 0
    
  end

end
