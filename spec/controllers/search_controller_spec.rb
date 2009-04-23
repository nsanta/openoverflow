require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do

  describe "handling GET 'index'" do
    before :each do
      @mock_search = mock('Search')
      @mock_questions = mock('Questions')
      @mock_search.should_receive(:paginate).with(:page => 1 , :per_page => 20).and_return(@mock_questions)
      Question.should_receive(:find_by_tsearch).with('query').and_return(@mock_search)
      get :index , :q => 'query'
    end
  
    it "should be success" do
      response.should be_success
    end
    
    it "should assigns the questions" do
      assigns[:questions].should == @mock_questions
    end
    
  end

end
