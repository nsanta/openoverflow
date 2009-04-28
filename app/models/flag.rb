# == Schema Information
# Schema version: 20090424001630
#
# Table name: flags
#
#  id              :integer         not null, primary key
#  flaggeagle_id   :integer
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
  
end
