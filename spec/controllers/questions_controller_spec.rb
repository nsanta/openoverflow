require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestionsController do

  before :each do
    controller.stub!(:require_user).and_return(true)
  end

  describe "handling GET 'index'" do
    before :each do
      @mock_questions = mock('Questions')
      Question.should_receive(:paginate).with(:all , :page => params[:page] , :per_page => 10 , :order => 'created_at DESC').and_return(@mock_questions)
      get :index
    end
    
    it "should be success" do
      response.should be_success
    end
    
    it "should assigns the questions" do
      assigns[:questions].should == @mock_questions
    end
    
  end


  describe "handling GET 'new'" do
    before :each do
      @question = Question.new
      Question.should_receive(:new).and_return(@question)
      get :new
    end
    
    it "should assign a new record" do
      assigns[:question].should be_new_record
    end
    
    it "should be success" do
      response.should be_success
    end
    
  end

  describe "handling POST 'create'" do
    before :each do
      @valid_params = {'title' => 'title' , 'body' => 'body'}
      @mock_question = mock_model(Question)
      Question.should_receive(:new).with(@valid_params).and_return(@mock_question)
      @mock_user = mock_model(User)
      controller.stub!(:current_user => @mock_user)
      @mock_question.should_receive("user=").with(@mock_user)
    end
    
    describe "with valid data" do
      before :each do
        @mock_question.should_receive(:save).and_return(true)
        post :create , :question => @valid_params
      end   
      
      it "should show a message" do
        flash[:notice].should == 'La pregunta ha sido creada'
      end
      
      it "should be redirected to index" do
        response.should redirect_to(questions_path)
      end
      
    end
    
    describe "with invalid data" do
      before :each do
        @mock_question.should_receive(:save).and_return(false)
        post :create , :question => @valid_params
      end   
      
      it "should show a message" do
        flash[:notice].should == 'La pregunta NO ha sido creada'
      end
      
      it "should render the new template" do
        response.should render_template('questions/new')
      end
      
    end
    
  end

  describe "handling GET 'show'" do
    before :each do
      @mock_question = mock_model(Question)
      Question.should_receive(:find).with('1').and_return(@mock_question)
      get :show , :id => '1'
    end
    
  
    it "should be success" do
      response.should be_success
    end
    
    it "should assigns the question" do
      assigns[:question].should == @mock_question
    end
  end

  describe "handling POST 'vote'" do
    before :each do
      @mock_question = mock_model(Question , :votes => mock('Proxy'))
      Question.should_receive(:find).with('1').and_return(@mock_question)
      @mock_user = mock_model(User , :id => '1')
      @mock_vote = mock_model(Vote)
      controller.stub!(:current_user => @mock_user)
    end
  
    describe "when the user has voted before" do
      before :each do
        @mock_question.votes.should_receive(:find_by_user_id).with('1').and_return(@mock_vote)
      end
    
      describe "when the vote type is the same value" do
        it "should show a message with a notification about that has vote before with the same value" do
          @mock_vote.stub!(:vote => '-1')
          post :vote , :id => '1' , :vote => '-1' , :format => :js
          flash[:notice].should == "Ya has votado esta pregunta"
        end
      end
      describe "when the vote type is a different value" do
        it "should update the vote attribute" do
          @mock_vote.stub!(:vote => '1')
          @mock_vote.should_receive(:update_attributes).with(:vote => '-1')
          post :vote , :id => '1' , :vote => '-1' , :format => :js
          flash[:notice].should == "Tu voto ha sido actualizado"
        end
      end
    end
  
    describe "when the user has not voted before" do
      before :each do
        @mock_question.votes.should_receive(:find_by_user_id).with('1').and_return(nil)
        @mock_question.votes.should_receive(:build).with(:user => @mock_user , :vote => '1').and_return(@mock_vote)
      end
    
      describe "when vote is valid" do
        it "should save the vote" do
          @mock_vote.should_receive(:save).and_return(true)
          post :vote , :id => '1' , :vote => '1' , :format => :js
          flash[:notice].should == "Tu voto a sido guardado"
        end
      end
     
      describe "when vote is not valid" do
        it "should not save the vote" do
          @mock_vote.should_receive(:save).and_return(false)
          post :vote , :id => '1' , :vote => '1' , :format => :js
          flash[:notice].should == "Tu voto NO a sido guardado"
        end
      end  
    end
    
    
  end

end
