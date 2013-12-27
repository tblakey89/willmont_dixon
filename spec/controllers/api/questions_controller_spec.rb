require 'spec_helper'

describe Api::QuestionsController do
  let(:question) { double(Question, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, section_id: 1, answer1: "Test", answer2: "Test2", answer3: "Test3", answer4: "Test4", answer: 1, save: true, update_attributes: true, destroy: true) }
  let(:questions) { double(Question, find: question, new: question) }
  let(:json) { { format: :json, pre_enrolment_test_id: 1, question: { name: "Test", order: 1, section_id: 1, answer1: "Test", answer2: "Test2", answer3: "Test3", answer4: "Test4", answer: 1 } } }

  describe "#index" do
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, name: "Test", questions: [question]) } }

    it "populates an array of questions" do
      get :index, pre_enrolment_test_id: 1, format: :json
      assigns(:questions).should eq([question])
    end

    context "with render views" do
      render_views

      it "renders the index view" do
        get :index, pre_enrolment_test_id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body).first
        result[question.class.name.downcase]['id'].should eql(1)
        result[question.class.name.downcase]['name'].should eql("Test")
        result[question.class.name.downcase]['order'].should eql(1)
        result[question.class.name.downcase]['answer1'].should eql("Test")
        result[question.class.name.downcase]['answer2'].should eql("Test2")
        result[question.class.name.downcase]['answer3'].should eql("Test3")
        result[question.class.name.downcase]['answer4'].should eql("Test4")
        result[question.class.name.downcase]['answer'].should eql(1)
      end
    end
  end

  describe "#show" do
    before do
      PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, questions: questions) }
    end

    it "assigns a question" do
      get :show, pre_enrolment_test_id: 1, id: 1, format: :json
      assigns(:question).should eq(question)
    end

    context "with render views" do
      render_views

      it "renders the show view" do
        get :show, pre_enrolment_test_id: 1, id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result[question.class.name.downcase]['id'].should eql(1)
        result[question.class.name.downcase]['name'].should eql("Test")
        result[question.class.name.downcase]['order'].should eql(1)
        result[question.class.name.downcase]['answer1'].should eql("Test")
        result[question.class.name.downcase]['answer2'].should eql("Test2")
        result[question.class.name.downcase]['answer3'].should eql("Test3")
        result[question.class.name.downcase]['answer4'].should eql("Test4")
        result[question.class.name.downcase]['answer'].should eql(1)
      end
    end
  end

  describe "#create" do
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, questions: questions) } }

    it "assigns a question" do
      post :create, json
      assigns(:question).should eq(question)
    end

    it "renders the show view" do
      post :create, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:question) { double(Question, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, save: false) }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#update" do
    let(:json) { { format: :json, pre_enrolment_test_id: 1, id: 1, question: { name: "Test", order: 1 } } }
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, questions: questions) } }

    it "assigns a question" do
      put :update, json
      assigns(:question).should eq(question)
    end

    it "renders the show view" do
      put :update, json
      response.status.should eq(200)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:question) { double(Question, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, update_attributes: false) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end

    context "with no question" do
      let(:questions) { double(Question, find: nil) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#destroy" do
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, questions: questions) } }

    context "question exists" do

      it "should delete the question" do
        delete :destroy, pre_enrolment_test_id: 1, id: 1
        response.status.should eq(204)
        response.body.should be_blank
      end
    end

    context "doesn't find question" do
      let(:questions) { double(Question, find: nil) }

      it "should return status 400" do
        delete :destroy, pre_enrolment_test_id: 1, id: 1
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end
end
