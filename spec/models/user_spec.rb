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

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  
  describe "associations" do
    it "should have many questions" do
      User.should have_many(:questions)
    end
    it "should have many question votes" do
      User.should have_many(:question_votes , :class_name => 'Vote' , :conditions => "votes.voteable_type= 'Question'")
    end
    it "should have many answers" do
      User.should have_many(:answers)
    end
    it "should have many comments" do
      User.should have_many(:comments)
    end
    it "should have many question votes" do
      User.should have_many(:answers_votes , :class_name => 'Vote' , :conditions => "votes.voteable_type= 'Answer'")
    end
    it "should have many favorites" do
      User.should have_many(:favorites)
    end
    it "should have many favorite questions" do
      User.should have_many(:favorite_questions , :through => :favorites , :source => 'questions')
    end
  end
  
  describe "validations" do
    it "should total_points not be less than 1" do
      user = User.create(:login => 'test' , :password => 'abc123' , :password_confirmation => 'abc123' , :email => 'test@test.com')
      user.total_points = 0
      user.should_not be_valid
    end
  end
  
end
