require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FavoritesController do

  describe "handling POST 'create'" do
    before :each do
      @mock_question = mock_model(Question)
      Question.should_receive(:find).with('1').and_return(@mock_question)
      @mock_user = mock_model(User , :favorite_questions => mock('questions'))
      @mock_user.favorite_questions.should_receive('<<').with(@mock_question)
      controller.stub!(:current_user => @mock_user)
      post :create , :id => '1'
    end
    it "should be success" do
      response.should be_success
    end
    it "should assign the question" do
      assigns[:question].should == @mock_question
    end
    
  end

end
