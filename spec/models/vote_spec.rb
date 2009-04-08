require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vote do
  before(:each) do
    @valid_attributes = {
      :vote => 1,
      :voteable_type => "Question",
      :voteable_id => 1,
      :user => mock_model(User)
    }
  end

  describe "validations" do
    it "should create a new instance given valid attributes" do
      @vote = Vote.create(@valid_attributes)
      @vote.should be_valid
    end
  end  
end
