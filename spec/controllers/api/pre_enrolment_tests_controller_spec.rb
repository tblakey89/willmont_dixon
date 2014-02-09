require 'spec_helper'

describe Api::PreEnrolmentTestsController do
  let(:pre_enrolment_test) { double(PreEnrolmentTest, id: 1, name: "Test", update_attributes: true) }
  let(:json) { { format: :json, pre_enrolment_test: { name: "Test2"} } }

  before { sign_in_user }

  describe "#index" do
    before { PreEnrolmentTest.stub(:all).and_return([pre_enrolment_test]) }

    it "populates an array of tests" do
      get :index, format: :json
      assigns(:pre_enrolment_tests).should eq([pre_enrolment_test])
    end

    context "with render_views" do
      render_views

      it "renders the index view" do
        get :index, format: :json
        response.should be_success
        result = JSON.parse(response.body).first
        result[pre_enrolment_test.class.name.downcase]['id'].should eql(1)
        result[pre_enrolment_test.class.name.downcase]['name'].should eql("Test")
      end
    end
  end

  describe "#show" do
    before { PreEnrolmentTest.stub(:find).with("1").and_return(pre_enrolment_test) }
    it "assigns a test" do
      get :show, id: pre_enrolment_test.id, format: :json
      assigns(:pre_enrolment_test).should eq(pre_enrolment_test)
    end

    context "with render_views" do
      render_views

      it "renders the show view" do
        get :show, id: pre_enrolment_test.id, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result[pre_enrolment_test.class.name.downcase]['id'].should eql(1)
        result[pre_enrolment_test.class.name.downcase]['name'].should eql("Test")
      end
    end
  end

  describe "#create" do
    before { PreEnrolmentTest.stub(:new).with({"name" => "Test2"}) { mock_model(PreEnrolmentTest, save: true, id: 2, name: "Test2") } }

    context "with render_views" do
      render_views

      it "renders the show view" do
        post :create, json
        response.status.should eq(201)
        result = JSON.parse(response.body)
        result["pre_enrolment_test"]['id'].should eql(2)
        result["pre_enrolment_test"]['name'].should eql("Test2")
      end
    end

    context "without valid information" do
      before { PreEnrolmentTest.stub(:new) { double(PreEnrolmentTest, save: false) } }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#update" do
    let(:json) { { format: :json, id: 1,  pre_enrolment_test: { name: "Test2"} } }
    before { PreEnrolmentTest.stub(:find).and_return(pre_enrolment_test) }

    context "with valid information" do
      it "assigns a test" do
        put :update, json
        assigns(:pre_enrolment_test).should eq(pre_enrolment_test)
      end

      context "renders the show view" do
        render_views

        it "renders the show view" do
          put :update, json
          response.status.should eq(200)
          result = JSON.parse(response.body)
          result[pre_enrolment_test.class.name.downcase]["id"].should eql(1)
          result[pre_enrolment_test.class.name.downcase]["name"].should eql("Test")
        end
      end
    end

    context "with invalid information" do
      before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, update_attributes: false) } }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end

      context "unable to find test" do
        before { PreEnrolmentTest.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

        it "renders nothing" do
          put :update, json
          response.status.should eq(404)
          response.body.should be_blank
        end
      end
    end
  end

  describe "#destroy" do
    context "test exists" do
      before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, destroy: true) } }

      context "finds a test" do
        it "should delete the test" do
          delete :destroy, id: 1
          response.status.should eq(204)
          response.body.should be_blank
        end
      end

      context "doesn't find a test" do
        before { PreEnrolmentTest.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

        it "should return status 404" do
          delete :destroy, id: 2
          response.status.should eq(404)
          response.body.should be_blank
        end
      end
    end
  end
end
