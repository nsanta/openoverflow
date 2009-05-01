require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Favorite do

  describe "associations" do
    it "should belong to user" do
      Favorite.should belong_to(:user)
    end
    
    it "should belong to question" do
      Favorite.should belong_to(:question)
    end
  end

  describe "validations" do
    it "should create a new instance given valid attributes" do
      @favorite = Factory(:favorite)
      @favorite.should be_valid
    end
    
    it "should require user" do
      @favorite = Factory.build(:favorite , :user => nil)
      @favorite.should_not be_valid
    end
    
    it "should require question" do
      @favorite = Factory.build(:favorite , :question => nil)
      @favorite.should_not be_valid
    end
  end  
end
