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
  end
  
  describe "validations" do
    it "should total_points not be less than 1" do
      user = User.create(:login => 'test' , :password => 'abc123' , :password_confirmation => 'abc123' , :email => 'test@test.com')
      user.total_points = 0
      user.should_not be_valid
    end
  end
  
end
