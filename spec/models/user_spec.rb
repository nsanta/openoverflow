require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  
  describe "associations" do
    it "should have many questions" do
      User.should have_many(:questions)
    end
  end
end
