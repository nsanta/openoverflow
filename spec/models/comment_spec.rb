require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  before(:each) do
    @valid_attributes = {
      :body => "value for body",
      :user => mock_model(User),
      :answer => mock_model(Answer)
    }
  end

  describe "associations" do
    it "should belong to user" do
      Comment.should belong_to(:user)
    end
    it "should belong to answer" do
      Comment.should belong_to(:answer)
    end
  end
  
  describe "validations" do
  
    it "should create a new instance given valid attributes" do
      @comment = Comment.new(@valid_attributes)
      @comment.should be_valid
    end
    
    it "should require the body" do
      @comment = Comment.new(@valid_attributes.merge(:body => nil))
      @comment.should_not be_valid
    end
    
    it "should require the user" do
      @comment = Comment.new(@valid_attributes.merge(:user => nil))
      @comment.should_not be_valid
    end
    
    it "should require the answer" do
      @comment = Comment.new(@valid_attributes.merge(:answer => nil))
      @comment.should_not be_valid
    end
    
  end  
end
