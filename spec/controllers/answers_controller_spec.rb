require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AnswersController do

  before :each do
    controller.stub!(:require_user).and_return(true)
    @mock_question = mock_model(Question)
    Question.stub!(:find).with('1').and_return(@mock_question)
    @mock_user = mock_model(User)
    controller.stub!(:current_user => @mock_user)
  end

  describe "filters" do
    it "should load question on before filter" do
      AnswersController.before_filters.should include(:load_question) 
    end
  end

  

  describe "handling POST 'create'" do
    before :each do
      @mock_answer = mock_model(Answer)
      @mock_question.stub!(:answers => mock('Proxy'))
      @mock_question.answers.should_receive(:build).with(:user => @mock_user , :body => 'body').and_return(@mock_answer)
    end
    
    describe "with valid data" do
    
      before :each do
        @mock_answer.should_receive(:save).and_return(true)
        post :create ,:question_id => '1', :id => '1' , :body => 'body'
      end
      
      it "should show a notification message 'The Answer has been created'" do
        flash[:notice].should == "La respuesta ha sido publicada"
      end
      
    end
    
    describe "with valid data" do
    
      before :each do
        @mock_answer.should_receive(:save).and_return(false)
        post :create ,:question_id => '1', :id => '1' , :body => 'body'
      end
      
      it "should show a notification message 'The Answer has NOT been created'" do
        flash[:notice].should == "La respuesta NO ha sido publicada"
      end
      
    end
    
  end

  describe "handling GET 'edit'" do
    before :each do
      @mock_answer = mock_model(Answer)
      @mock_user.stub!(:answers => mock('Proxy'))
      @mock_user.answers.should_receive(:find).with('1').and_return(@mock_answer)
      get :edit , :question_id => '1' , :id => '1'
    end  
  
    it "should assigns the answer" do
      assigns[:answer].should == @mock_answer
    end
    it "should be success" do
      response.should be_success    
    end
  end

  describe "handling POST 'vote'" do
    before :each do
      @mock_answer = mock_model(Question , :votes => mock('Proxy'))
      Answer.should_receive(:find).with('1').and_return(@mock_answer)
      @mock_user = mock_model(User , :id => '1')
      @mock_vote = mock_model(Vote)
      controller.stub!(:current_user => @mock_user)
    end
  
    describe "when the user has voted before" do
      before :each do
        @mock_answer.votes.should_receive(:find_by_user_id).with('1').and_return(@mock_vote)
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
        @mock_answer.votes.should_receive(:find_by_user_id).with('1').and_return(nil)
        @mock_answer.votes.should_receive(:build).with(:user => @mock_user , :vote => '1').and_return(@mock_vote)
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


  describe "handling POST 'flag'" do
    before :each do
      @mock_answer = mock_model(Answer)
      Answer.should_receive(:find).with('1').and_return(@mock_answer)
      @mock_answer.should_receive(:update_attributes).with(:flag => true)
      post :flag , :id => '1'
    end
    
    it "should be success" do
      response.should be_success
    end
    
    
    it "should assign the answer" do
      assigns[:answer].should == @mock_answer
    end
    
  end
  
  
  describe "handling POST 'select'" do
    before :each do
      @mock_answer = mock_model(Answer , :question => @mock_question)
      Answer.should_receive(:find).with('1').and_return(@mock_answer)
    end
  
    describe "when the question owner is the user" do
      before :each do
        @mock_question.stub!(:user => @mock_user)
        @mock_answer.should_receive('select!').and_return(@mock_prev)
        post :select , :id => '1'
      end 
      
      it "should return the previous answer selected" do
        assigns[:prev_selected].should == @mock_prev
      end
      
      it "should show message 'Tu seleccion ha sido guardada'" do
        flash[:notice].should == 'Tu seleccion ha sido guardada'
      end
      
    end
    
    describe "when the question owner is not the user" do
      before :each do
        @mock_prev = mock_model(Answer)
        @mock_question.stub!(:user => nil)
        post :select , :id => '1'
      end
      
      
      it "should show message 'Tu no estas habilitado para seleccionar la respuesta'" do
        flash[:notice].should == 'Tu no estas habilitado para seleccionar la respuesta'
      end
    end
    
    
  end
  
end
