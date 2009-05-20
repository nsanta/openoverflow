require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::QuestionsController do
  before :each do
    controller.stub!(:require_user).and_return(true)
    controller.stub!(:require_admin).and_return(true)
  end


  describe "handling GET 'index'" do
    before :each do
      @mock_flags = mock('Flags')
      @paginated_flags = mock('Paginated Flags')
      Flag.should_receive(:questions).and_return(@mock_flags)
      @mock_flags.should_receive(:paginate).with(:page => 1 , :per_page => 20).and_return(@paginated_flags)
      get :index
    end

    it "should assign flagged questions" do
      assigns[:flags].should == @paginated_flags
    end
    it "should be success" do
      response.should be_success
    end
  end


  describe "handling GET 'show'" do
    before :each do
      @mock_question = mock_model(Question)
      Question.should_receive(:find).with('1').and_return(@mock_question)
      get :show , :id => '1'
    end

    it "should assign the question flagged" do
      assigns[:question].should == @mock_question
    end
  end


  describe "handling PUT 'ban'" do
    before :each do
      @mock_question = mock_model(Question, :banned => true)
      @mock_flag = mock_model(Flag, :flaggeable => @mock_question)
      @mock_question.should_receive(:toggle!).with(:banned)
      Flag.should_receive(:find).with('1').and_return(@mock_flag)
    end

    describe "when is banned" do
      it "should assign the message that has been banned" do
        @mock_question.should_receive(:banned).and_return(true)
        put :ban, :id => '1'
        flash[:notice].should == "La pregunta ha sido restringida"
      end
    end

    describe "when is unbanned" do
      it "should assign the message that has been unbanned" do
        @mock_question.should_receive(:banned).and_return(false)
        put :ban, :id => '1'
        flash[:notice].should == "La pregunta ha sido aceptada nuevamente"
      end
    end

    it "should redirect" do
      put :ban, :id => '1'
      response.should redirect_to(admin_questions_path)
    end

    it "should assign the banned question" do
      put :ban, :id => '1'
      assigns[:question].should == @mock_question
    end
  end


  describe "handling DELETE 'destroy'" do
    before :each do
      @mock_flag = mock_model(Flag)
      @mock_flag.should_receive(:destroy)
      Flag.should_receive(:find).with('1').and_return(@mock_flag)
      delete :destroy, :id => '1'
    end

    it "should be redirected to index path" do
      response.should redirect_to(admin_questions_path)
    end

    it "should assign the flagged to be destroyed" do
      assigns[:flag].should == @mock_flag
    end

    it "should assign the message that the flag has been deleted" do
      flash[:notice].should == "La reportacion ha sido eliminada"
    end
  end

end
