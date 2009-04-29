require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feedback do
  before(:each) do
    @mock_user = mock_model(User, :email=>'juan@example.com')
    @valid_attributes = {
      :user => @mock_user,
      :title => "Suggesting something",
      :body => "It's all really really great'"
    }
  end


  describe 'validations' do
    it "should create a new instance given valid attributes" do
      @feedback = Feedback.new(@valid_attributes)
      @feedback.should be_valid
    end

    it "should require a title" do
      @feedback = Feedback.new(@valid_attributes.merge!(:title => ''))
      @feedback.should_not be_valid
      @feedback.errors_on(:title).should_not be_empty
    end

    it "should require a body" do
      @feedback = Feedback.new(@valid_attributes.merge!(:body => ''))
      @feedback.should_not be_valid
      @feedback.errors_on(:body).should_not be_empty
    end

    it "should require an email when not user is present" do
      @feedback = Feedback.new(@valid_attributes.merge!(:user => nil))
      @feedback.should_not be_valid
      @feedback.errors_on(:email).should_not be_empty
    end

    it "should be valid without an user but with an email" do
      @feedback = Feedback.new(@valid_attributes.merge!(:user => nil, :email => 'pepe@example.com'))
      @feedback.should be_valid
    end

    it "should set the user's email when create" do
      @feedback = Feedback.new(@valid_attributes.merge!(:email => 'pepe@example.com'))
      @feedback.should be_valid
      @feedback.email.should == 'juan@example.com'
    end
  end

end
