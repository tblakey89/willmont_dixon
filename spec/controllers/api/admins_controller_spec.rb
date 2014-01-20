require 'spec_helper'

describe Api::AdminsController do
  let!(:admin) { double(User, id: 1, first_name: "Test", last_name: "Test", email: "test@test.com", role: 1, job: "Tester", health_issues: false, is_supervisor: false, cscs_number: "testest", cscs_expiry_date: "2013-12-26", date_of_birth: "2013-12-26", national_insurance: "JG121212G", completed_pre_enrolment: "2013-12-26", contact_number: "07777777777", address_line_1: "Test", address_line_2: "Test", city: "Test", postcode: "cb6 2jx", save: true, update_attributes: true, destroy: true, add_role: true) }
  let(:json) { { format: :json, admin: { first_name: "Test" } } }
  before do
    allow_message_expectations_on_nil
    request.env['warden'].stub(:authenticate).and_return(admin)
    Api::AdminsController.any_instance.stub(:current_admin).and_return(admin)
    Api::AdminsController.any_instance.stub(:authorize).and_return(true)
    Api::AdminsController.any_instance.stub(:authenticate).and_return(true)
  end

  describe "#index" do
    before { User.stub(:where).and_return([admin]) }

    it "populates an array of admins" do
      get :index, format: :json
      assigns(:admins).should eq([admin])
    end

    context "with render_views" do
      render_views

      it "renders the index view" do
        get :index, format: :json
        response.should be_success
        result = JSON.parse(response.body).first[1].first
        result["admin"]['id'].should eql(1)
        result["admin"]['first_name'].should eql("Test")
        result["admin"]['last_name'].should eql("Test")
        result["admin"]['email'].should eql("test@test.com")
        result["admin"]['role'].should eql(1)
      end
    end
  end

  describe "#show" do
    before { User.stub(:find).with("1").and_return(admin) }

    it "assigns a test" do
      get :show, id: admin.id, format: :json
      assigns(:admin).should eq(admin)
    end

    context "with render_views" do
      render_views

      it "renders the show view" do
        get :show, id: admin.id, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result["admin"]['id'].should eql(1)
        result["admin"]['first_name'].should eql("Test")
        result["admin"]['last_name'].should eql("Test")
        result["admin"]['email'].should eql("test@test.com")
        result["admin"]['role'].should eql(1)
      end
    end
  end

  describe "#create" do
    before { User.stub(:new).and_return(admin) }

    it "assigns a admin" do
      post :create, json
      assigns(:admin).should eq(admin)
    end

    it "renders the show view" do
      post :create, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:admin) { double(User, add_role: true, save: false) }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#update" do
    before { User.stub(:find).and_return(admin) }
    let(:json) { { format: :json, id: 1, admin: { first_name: "Test" } } }

    it "assigns a admin" do
      put :update, json
      assigns(:admin).should eq(admin)
    end

    it "renders the show view" do
      put :update, json
      response.status.should eq(200)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:admin) { double(User, update_attributes: false) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end

    context "with no admin" do
      before { User.stub(:find).and_return(nil) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#destroy" do
    before { User.stub(:find).and_return(admin) }

    it "should delete the admin" do
      delete :destroy, id: 1
      response.status.should eq(204)
      response.body.should be_blank
    end

    context "doesn't find question" do
      before { User.stub(:find).and_return(nil) }

      it "should return status 400" do
        delete :destroy, id: 1
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end
end
