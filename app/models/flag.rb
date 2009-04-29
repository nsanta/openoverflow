# == Schema Information
# Schema version: 20090424001630
#
# Table name: flags
#
#  id              :integer         not null, primary key
#  flaggeable_id   :integer
#  flaggeable_type :string(255)
#  user_id         :integer
#  body            :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Flag < ActiveRecord::Base

  belongs_to :user
  belongs_to :flaggeable , :polymorphic => true
  
  validates_presence_of :user , :flaggeable , :body  
  
  after_create {|record| record.add_points(5)}
  
  named_scope :questions , :conditions => "flaggeable_type = 'Question'" , :order => 'created_at DESC'
  named_scope :answers , :conditions => "flaggeable_type = 'Answer'", :order => 'created_at DESC'
 
  def add_points(points = 1)
    self.user.total_points ||= 0
    self.user.total_points += points
    self.user.save
  end
  
end
