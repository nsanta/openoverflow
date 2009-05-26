require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserBadge do
  before(:each) do
    @valid_attributes = {
      :user => ,
      :badge => 
    }
  end

  it "should create a new instance given valid attributes" do
    UserBadge.create!(@valid_attributes)
  end
end
