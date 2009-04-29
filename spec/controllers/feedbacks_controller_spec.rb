require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeedbacksController do

  def mock_feedback(stubs={})
    @mock_feedback ||= mock_model(Feedback, stubs)
  end


  describe "handling GET /new" do
    it "exposes a new feedback as @feedback" do
      Feedback.should_receive(:new).and_return(mock_feedback)
      get :new
      assigns[:feedback].should equal(mock_feedback)
    end
  end


  describe "POST create" do

    describe "with valid params" do
      it "exposes a newly created feedback as @feedback" do
        Feedback.should_receive(:new).with({'these' => 'params'}).and_return(mock_feedback(:save => true))
        post :create, :feedback => {:these => 'params'}
        assigns(:feedback).should equal(mock_feedback)
      end

      it "redirects to the root path" do
        Feedback.stub!(:new).and_return(mock_feedback(:save => true))
        post :create, :feedback => {}
        response.should redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "exposes a newly created but unsaved feedback as @feedback" do
        Feedback.stub!(:new).with({'these' => 'params'}).and_return(mock_feedback(:save => false))
        post :create, :feedback => {:these => 'params'}
        assigns(:feedback).should equal(mock_feedback)
      end

      it "re-renders the 'new' template" do
        Feedback.stub!(:new).and_return(mock_feedback(:save => false))
        post :create, :feedback => {}
        response.should render_template('new')
      end
    end
  end


end
