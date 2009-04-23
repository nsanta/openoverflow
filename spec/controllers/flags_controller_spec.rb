require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FlagsController do
  before :each do
    controller.stub!(:require_user).and_return(true)
  end
  
  
  describe "filters" do
    it "should load flaggeable on before filter" do
      FlagsController.before_filters.should include(:load_flaggeable) 
    end
  end 

  describe "pivate methods loaded on filters" do
    before :each do
      @mock_flaggeable = mock('Flaggeable')
    end
    it "should load a question as a flaggeable" do
      Question.should_receive(:find).with('1').and_return(@mock_flaggeable)
      get :new , :question_id => '1'
      assigns[:flaggeable].should == @mock_flaggeable
    end
    it "should load a question as a flaggeable" do
      Answer.should_receive(:find).with('1').and_return(@mock_flaggeable)
      get :new , :answer_id => '1'
      assigns[:flaggeable].should == @mock_flaggeable
    end
  end

  describe "handling GET 'new'" do
    before :each do
      Question.should_receive(:find).with('1').and_return(@mock_flaggeable)
      get :new , :question_id => '1'
    end
    
    it "should be success" do
      response.should be_success
    end
    
  end

end
