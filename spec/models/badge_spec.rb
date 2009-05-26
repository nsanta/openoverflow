require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Badge do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :value => "value for value",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Badge.create!(@valid_attributes)
  end
end
