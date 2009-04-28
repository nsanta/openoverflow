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

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Flag do
  before(:each) do
    @valid_attributes = {
      :flaggeable => mock_model(Question),
      :user => mock_model(User),
      :body => "value for body"
    }
  end

  describe "associations" do
    it "should belong to user" do
      Flag.should belong_to(:user)
    end
    
    it "should belong to faggeable" do
      Flag.should belong_to(:flaggeable , :polymorphic => true, :foreign_type=>"flaggeable_type")
    end
  end
  
  describe "validations" do
    it "should create a new instance given valid attributes" do
      @flag = Flag.new(@valid_attributes)
      @flag.should be_valid
    end
    
    it "should require the user" do
      @flag = Flag.new(@valid_attributes.merge(:user => nil))
      @flag.should_not be_valid
    end
    
    
    it "should require the flaggeable" do
      @flag = Flag.new(@valid_attributes.merge(:flaggeable => nil))
      @flag.should_not be_valid
    end
    
    it "should require the body" do
      @flag = Flag.new(@valid_attributes.merge(:body => nil))
      @flag.should_not be_valid
    end
  end
end
