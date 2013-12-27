require 'spec_helper'

describe Api::NextOfKinsController do
  let(:next_of_kin) { double(NextOfKin, id: 1, first_name: "Test", last_name: "Test", relationship: "Test", contact_number: "07777777777", address_line_1: "Test", address_line_2: "Test", city: "Test", postcode: "cb6 2jx", user_id: 1, save: true, update_attributes: true, destroy: true) }
  let(:next_of_kins) { double(NextOfKin, find: next_of_kin, new: next_of_kin) }
  let(:json) { { format: :json, user_id: 1, next_of_kin: {first_name: "Test", last_name: "Test", relationship: "Test", contact_number: "07777777777", address_line_1: "Test", address_line_2: "Test", city: "Test", postcode: "cb6 2jx", user_id: 1 } } }

  describe "#index" do
    before { User.stub(:find) { double(User, id: 1, next_of_kins: [next_of_kin]) }}

    it "populates an array of next_of_kin" do
      get :index, user_id: 1, format: :json
      assigns(:next_of_kins).should eq([next_of_kin])
    end

    context "with render_views" do
      render_views

      it "renders the index view" do
        get :index, user_id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body).first
        result[next_of_kin.class.name.downcase]['id'].should eql(1)
        result[next_of_kin.class.name.downcase]['first_name'].should eql('Test')
        result[next_of_kin.class.name.downcase]['last_name'].should eql("Test")
        result[next_of_kin.class.name.downcase]['relationship'].should eql("Test")
        result[next_of_kin.class.name.downcase]['contact_number'].should eql('07777777777')
        result[next_of_kin.class.name.downcase]['address_line_1'].should eql("Test")
        result[next_of_kin.class.name.downcase]['address_line_2'].should eql("Test")
        result[next_of_kin.class.name.downcase]['city'].should eql("Test")
        result[next_of_kin.class.name.downcase]['postcode'].should eql("cb6 2jx")
      end
    end
  end

  describe "#show" do
    before { User.stub(:find) { double(User, next_of_kins: next_of_kins) } }

    it "assigns a next_of_kin" do
      get :show, user_id: 1, id: 1, format: :json
      assigns(:next_of_kin).should eq(next_of_kin)
    end

    context "renders the show view" do
      render_views

      it "renders the show view" do
        get :show, user_id: 1, id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result[next_of_kin.class.name.downcase]['id'].should eql(1)
        result[next_of_kin.class.name.downcase]['first_name'].should eql('Test')
        result[next_of_kin.class.name.downcase]['last_name'].should eql("Test")
        result[next_of_kin.class.name.downcase]['relationship'].should eql("Test")
        result[next_of_kin.class.name.downcase]['contact_number'].should eql('07777777777')
        result[next_of_kin.class.name.downcase]['address_line_1'].should eql("Test")
        result[next_of_kin.class.name.downcase]['address_line_2'].should eql("Test")
        result[next_of_kin.class.name.downcase]['city'].should eql("Test")
        result[next_of_kin.class.name.downcase]['postcode'].should eql("cb6 2jx")
      end
    end
  end

  describe "#create" do
    before { User.stub(:find) { double(User, id: 1, next_of_kins: next_of_kins) } }

    it "assigns a next of kin" do
      post :create, json
      assigns(:next_of_kin).should eq(next_of_kin)
    end

    it "renders the show view" do
      post :create, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:next_of_kin) { double(NextOfKin, id: 1, user_id: 1, save: false) }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#update" do
    let(:json) { { format: :json, user_id: 1, id: 1, next_of_kin: { first_name: "Test" } } }
    before { User.stub(:find) { double(User, id: 1, next_of_kins: next_of_kins) } }

    it "assigns a next_of_kin" do
      put :update, json
      assigns(:next_of_kin).should eq(next_of_kin)
    end

    it "renders the show view" do
      put :update, json
      response.status.should eq(200)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:next_of_kin) { double(User, id: 1, update_attributes: false) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end

    context "with no next_of_kin" do
      let(:next_of_kins) { double(User, find: nil) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#destroy" do
    before { User.stub(:find) { double(User, id: 1, next_of_kins: next_of_kins) } }

    it "should delete the next_of_kin" do
      delete :destroy, user_id: 1, id: 1
      response.status.should eq(204)
      response.body.should be_blank
    end

    context "doesn't find next_of_kin" do
      let(:next_of_kins) { double(User, find: nil) }

      it "should return status 400" do
        delete :destroy, user_id: 1, id: 1
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end
end
