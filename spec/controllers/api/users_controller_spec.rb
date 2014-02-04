require 'spec_helper'

describe Api::UsersController do
  let!(:user) { double(User, id: 1, first_name: "Test", last_name: "Test", email: "test@test.com", role: 1, job: "Tester", health_issues: false, is_supervisor: false, cscs_number: "testest", cscs_expiry_date: "2013-12-26", date_of_birth: "2013-12-26", national_insurance: "JG121212G", completed_pre_enrolment: "2013-12-26", contact_number: "07777777777", address_line_1: "Test", address_line_2: "Test", city: "Test", postcode: "cb6 2jx", save: true, update_attributes: true, work_at_height: false, scaffolder: false, ground_worker: false, operate_machinery: false, lift_loads: false, destroy: true) }
  let(:json) { { format: :json, user: { first_name: "Test" } } }

  before do
    allow_message_expectations_on_nil
    request.env['warden'].stub(:authenticate).and_return(user)
    Api::UsersController.any_instance.stub(:current_user).and_return(user)
    Api::UsersController.any_instance.stub(:authorize).and_return(true)
    Api::UsersController.any_instance.stub(:authenticate).and_return(true)
  end

  describe "#index" do
    before { User.stub(:where).and_return([user]) }

    it "populates an array of users" do
      get :index, format: :json
      assigns(:users).should eq([user])
    end

    context "with render_views" do
      render_views

      it "renders the index view" do
        get :index, format: :json
        response.should be_success
        result = JSON.parse(response.body).first
        result[user.class.name.downcase]['id'].should eql(1)
        result[user.class.name.downcase]['first_name'].should eql("Test")
        result[user.class.name.downcase]['last_name'].should eql("Test")
        result[user.class.name.downcase]['email'].should eql("test@test.com")
        result[user.class.name.downcase]['role'].should eql(1)
        result[user.class.name.downcase]['job'].should eql("Tester")
        result[user.class.name.downcase]['health_issues'].should eql(false)
        result[user.class.name.downcase]['is_supervisor'].should eql(false)
        result[user.class.name.downcase]['cscs_number'].should eql("testest")
        result[user.class.name.downcase]['cscs_expiry_date'].should eql("2013-12-26")
        result[user.class.name.downcase]['date_of_birth'].should eql("2013-12-26")
        result[user.class.name.downcase]['national_insurance'].should eql("JG121212G")
        result[user.class.name.downcase]['completed_pre_enrolment'].should eql("2013-12-26")
        result[user.class.name.downcase]['contact_number'].should eql("07777777777")
        result[user.class.name.downcase]['address_line_1'].should eql("Test")
        result[user.class.name.downcase]['address_line_2'].should eql("Test")
        result[user.class.name.downcase]['city'].should eql("Test")
        result[user.class.name.downcase]['postcode'].should eql("cb6 2jx")
      end
    end
  end

  describe "#show" do
    before { User.stub(:find).with("1").and_return(user) }

    it "assigns a test" do
      get :show, id: user.id, format: :json
      assigns(:user).should eq(user)
    end

    context "with render_views" do
      render_views

      it "renders the show view" do
        get :show, id: user.id, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result[user.class.name.downcase]['id'].should eql(1)
        result[user.class.name.downcase]['first_name'].should eql("Test")
        result[user.class.name.downcase]['last_name'].should eql("Test")
        result[user.class.name.downcase]['email'].should eql("test@test.com")
        result[user.class.name.downcase]['role'].should eql(1)
        result[user.class.name.downcase]['job'].should eql("Tester")
        result[user.class.name.downcase]['health_issues'].should eql(false)
        result[user.class.name.downcase]['is_supervisor'].should eql(false)
        result[user.class.name.downcase]['cscs_number'].should eql("testest")
        result[user.class.name.downcase]['cscs_expiry_date'].should eql("2013-12-26")
        result[user.class.name.downcase]['date_of_birth'].should eql("2013-12-26")
        result[user.class.name.downcase]['national_insurance'].should eql("JG121212G")
        result[user.class.name.downcase]['completed_pre_enrolment'].should eql("2013-12-26")
        result[user.class.name.downcase]['contact_number'].should eql("07777777777")
        result[user.class.name.downcase]['address_line_1'].should eql("Test")
        result[user.class.name.downcase]['address_line_2'].should eql("Test")
        result[user.class.name.downcase]['city'].should eql("Test")
        result[user.class.name.downcase]['postcode'].should eql("cb6 2jx")
        result[user.class.name.downcase]['work_at_height'].should eql(false)
        result[user.class.name.downcase]['scaffolder'].should eql(false)
        result[user.class.name.downcase]['ground_worker'].should eql(false)
        result[user.class.name.downcase]['operate_machinery'].should eql(false)
        result[user.class.name.downcase]['lift_loads'].should eql(false)
      end
    end
  end

  describe "#create" do
    before { User.stub(:new).and_return(user) }

    it "assigns a user" do
      post :create, json
      assigns(:user).should eq(user)
    end

    it "renders the show view" do
      post :create, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:user) { double(User, save: false, errors: "Test") }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
      end
    end
  end

  describe "#update" do
    before { User.stub(:find).and_return(user) }
    let(:json) { { format: :json, id: 1, user: { first_name: "Test" } } }

    it "assigns a user" do
      put :update, json
      assigns(:user).should eq(user)
    end

    it "renders the show view" do
      put :update, json
      response.status.should eq(200)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:user) { double(User, update_attributes: false, errors: "Test") }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
      end
    end

    context "with no user" do
      before { User.stub(:find).and_return(nil) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#destroy" do
    before { User.stub(:find).and_return(user) }

    it "should delete the user" do
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

  describe "#disciplinary_cards" do
    let(:disciplinary_card) { double(DisciplinaryCard) }
    before do
      user.stub(:disciplinary_cards).and_return([disciplinary_card])
      User.stub(:find).and_return(user)
    end

    it "should assign disciplinary_cards" do
      get :disciplinary_cards, id: user.id, format: :json
      assigns(:disciplinary_cards).should eq([disciplinary_card])
    end

    it "should render the right template" do
      get :disciplinary_cards, id: user.id, format: :json
      response.should be_success
      response.should render_template :disciplinary_cards
    end
  end
end
