require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AnswersController do

  before :each do
    controller.stub!(:require_user).and_return(true)
  end

  describe "filters" do
    it "should load question on before filter" do
      AnswersController.before_filters.should include(:load_question) 
    end
  end

  describe "handling POST 'create'"

end
