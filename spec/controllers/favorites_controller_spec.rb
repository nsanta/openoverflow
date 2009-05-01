require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FavoritesController do
  before :each do
    @mock_user = mock_model(User)
    controller.stub!(:current_user => @mock_user)
  end


  describe "handling POST 'create'" do
    before :each do
      @mock_question = mock_model(Question)
      Question.should_receive(:find).with('1').and_return(@mock_question)
      @mock_user.stub!(:favorite_questions => mock('questions'))
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

  
  describe "handling DELETE 'destroy'" do
    before :each do
      @mock_favorite = mock_model(Favorite , :destroy => true)
      @mock_user.stub!(:favorites => mock('favorites'))
      @mock_user.favorites.should_receive(:find_by_question_id).with('1').and_return(@mock_favorite)
      delete :destroy , :id => '1'
    end
  
    it "should be success" do
      response.should be_success
    end
    
    it "should assing the favorites" do
      assigns[:favorite].should == @mock_favorite
    end
  end

end
