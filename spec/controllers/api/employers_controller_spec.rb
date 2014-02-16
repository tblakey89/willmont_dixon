require 'spec_helper'

describe Api::EmployersController do
  let(:employer) { double(Employer, id: 1, company_name: "Test", contact_number: "07777777777", address_line_1: "Test", address_line_2: "Test", city: "Test", postal_code: "cb6 2jx", user_id: 1, save: true, update_attributes: true, destroy: true) }
  let(:employers) { double(Employer, find: employer, new: employer) }
  let(:json) { { format: :json, user_id: 1, employer: {company_name: "Test", contact_number: "07777777777", address_line_1: "Test", address_line_2: "Test", city: "Test", postal_code: "cb6 2jx", user_id: 1 } } }

  before { sign_in_user }

  describe "#index" do
    before { User.stub(:find) { double(User, id: 1, employers: [employer]) }}

    it "populates an array of employer" do
      get :index, user_id: 1, format: :json
      assigns(:employers).should eq([employer])
    end

    context "with render_views" do
      render_views

      it "renders the index view" do
        get :index, user_id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body).first
        result[employer.class.name.downcase]['id'].should eql(1)
        result[employer.class.name.downcase]['company_name'].should eql('Test')
        result[employer.class.name.downcase]['contact_number'].should eql('07777777777')
        result[employer.class.name.downcase]['address_line_1'].should eql("Test")
        result[employer.class.name.downcase]['address_line_2'].should eql("Test")
        result[employer.class.name.downcase]['city'].should eql("Test")
        result[employer.class.name.downcase]['postal_code'].should eql("cb6 2jx")
      end
    end
  end

  describe "#show" do
    before { User.stub(:find) { double(User, employers: employers) } }

    it "assigns a employer" do
      get :show, user_id: 1, id: 1, format: :json
      assigns(:employer).should eq(employer)
    end

    context "renders the show view" do
      render_views

      it "renders the show view" do
        get :show, user_id: 1, id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result[employer.class.name.downcase]['id'].should eql(1)
        result[employer.class.name.downcase]['company_name'].should eql("Test")
        result[employer.class.name.downcase]['contact_number'].should eql('07777777777')
        result[employer.class.name.downcase]['address_line_1'].should eql("Test")
        result[employer.class.name.downcase]['address_line_2'].should eql("Test")
        result[employer.class.name.downcase]['city'].should eql("Test")
        result[employer.class.name.downcase]['postal_code'].should eql("cb6 2jx")
      end
    end
  end

  describe "#create" do
    before { User.stub(:find) { double(User, id: 1, employers: employers) } }

    it "assigns a next of kin" do
      post :create, json
      assigns(:employer).should eq(employer)
    end

    it "renders the show view" do
      post :create, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:employer) { double(Employer, id: 1, user_id: 1, save: false, errors: "Test") }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
      end
    end
  end

  describe "#update" do
    let(:json) { { format: :json, user_id: 1, id: 1, employer: { company_name: "Test" } } }
    before { User.stub(:find) { double(User, id: 1, employers: employers) } }

    it "assigns a employer" do
      put :update, json
      assigns(:employer).should eq(employer)
    end

    it "renders the show view" do
      put :update, json
      response.status.should eq(200)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:employer) { double(User, id: 1, update_attributes: false, errors: "Test") }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
      end
    end

    context "with no employer" do
      let(:employers) { double(User) }
      before { employers.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(404)
        response.body.should be_blank
      end
    end
  end

  describe "#destroy" do
    before { User.stub(:find) { double(User, id: 1, employers: employers) } }

    it "should delete the employer" do
      delete :destroy, user_id: 1, id: 1
      response.status.should eq(204)
      response.body.should be_blank
    end

    context "doesn't find employer" do
      let(:employers) { double(User) }
      before { employers.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

      it "should return status 400" do
        delete :destroy, user_id: 1, id: 1
        response.status.should eq(404)
        response.body.should be_blank
      end
    end
  end
end
