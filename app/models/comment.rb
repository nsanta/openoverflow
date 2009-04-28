# == Schema Information
# Schema version: 20090424001630
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  body       :text
#  user_id    :integer
#  answer_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
  
  validates_presence_of :body , :user , :answer
  
end
