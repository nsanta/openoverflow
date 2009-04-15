require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Question do
  before(:each) do
    @valid_attributes = {
      :title => "What is the best Framework?",
      :body => "body for description",
      :user => mock_model(User),
      :votes_average => 0
    }
  end

  describe "associations" do
    it "should belong to a user" do
      Question.should belong_to(:user)
    end
    it "should have many question votes" do
      Question.should have_many(:votes, :as => :voteable)
    end
    it "should have many answers" do
      Question.should have_many(:answers)
    end
  end

  describe "validations" do
    
    it "should create a new instance given valid attributes" do
      @question = Question.new(@valid_attributes)
      @question.should be_valid
    end
    
    it "should require title" do
      @question = Question.new(@valid_attributes.merge(:title => nil))
      @question.should_not be_valid
    end
    
    it "should require body" do
      @question = Question.new(@valid_attributes.merge(:body => nil))
      @question.should_not be_valid
    end
    
    it "should require user" do
      @question = Question.new(@valid_attributes.merge(:user => nil))
      @question.should_not be_valid
    end
    
    it "should require the lenght of  title" do
      @question = Question.new(@valid_attributes.merge(:title => '1'))
      @question.should_not be_valid
      @question = Question.new(@valid_attributes.merge(:title => 'aaaaaaaaaasddddddddddddddvvvvvvvvvvvvvvrrrrrrrrrrrrrweeeeeeeeeeee'))
      @question.should_not be_valid
    end
    
  end  
end
