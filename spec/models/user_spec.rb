require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  
  describe "associations" do
    it "should have many questions" do
      User.should have_many(:questions)
    end
    it "should have many question votes" do
      User.should have_many(:question_votes , :class_name => 'Vote' , :conditions => "votes.voteable_type= 'Question'")
    end
    
  end
end
