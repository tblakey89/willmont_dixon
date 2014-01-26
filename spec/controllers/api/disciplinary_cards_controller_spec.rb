require 'spec_helper'

describe Api::DisciplinaryCardsController do
  let(:disciplinary_card) { double(DisciplinaryCard, id: 1, user: double(User), colour: "Green", reason: "Test", location: "Test", save: true, update_attributes: true, destroy: true) }
  let(:disciplinary_cards) { double(DisciplinaryCard, find: disciplinary_card, new: disciplinary_card) }
  let(:json) { { format: :json, disciplinary_card: { reason: "Test" } } }

  before { sign_in_user }

  describe "#index" do
    before { DisciplinaryCard.stub(:all).and_return([disciplinary_card]) }

    it "populates an array of tests" do
      get :index, format: :json
      assigns(:disciplinary_cards).should eq([disciplinary_card])
    end

    context "with render views" do
      render_views

      it "renders the index view" do
        get :index, format: :json
        response.should be_success
        result = JSON.parse(response.body).first
        result[disciplinary_card.class.name.downcase]['id'].should eq(1)
        result[disciplinary_card.class.name.downcase]['reason'].should eq("Test")
        result[disciplinary_card.class.name.downcase]['colour'].should eq("Green")
        result[disciplinary_card.class.name.downcase]['location'].should eq("Test")
      end
    end
  end

  describe "#show" do
    before { DisciplinaryCard.stub(:find).and_return(disciplinary_card) }

    it "assigns a test" do
      get :show, id: disciplinary_card.id, format: :json
      assigns(:disciplinary_card).should eq(disciplinary_card)
    end

    context "with render_views" do
      render_views

      it "renders the show view" do
        get :show, id: disciplinary_card.id, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result[disciplinary_card.class.name.downcase]['id'].should eq(1)
        result[disciplinary_card.class.name.downcase]['reason'].should eq("Test")
        result[disciplinary_card.class.name.downcase]['colour'].should eq("Green")
        result[disciplinary_card.class.name.downcase]['location'].should eq("Test")
      end
    end
  end

  describe "#create" do
    before { DisciplinaryCard.stub(:new).and_return(disciplinary_card) }

    it "assigns a disciplinary card" do
      post :create, json
      assigns(:disciplinary_card).should eq(disciplinary_card)
    end

    it "renders the show view" do
      post :create, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:disciplinary_card) { double(DisciplinaryCard, save: false, errors: "test") }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
      end
    end
  end

  describe "#update" do
    before { DisciplinaryCard.stub(:find).and_return(disciplinary_card) }
    let(:json) {{ format: :json, id: 1, disciplinary_card: { reason: "Test" } } }

    it "assigns a disciplinary card" do
      put :update, json
      assigns(:disciplinary_card).should eq(disciplinary_card)
    end

    it "renders the disciplinary card view" do
      put :update, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:disciplinary_card) { double(DisciplinaryCard, update_attributes: false, errors: "test") }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
      end
    end

    context "with no disciplinary card" do
      before { DisciplinaryCard.stub(:find).and_return(nil) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#destroy" do
    before { DisciplinaryCard.stub(:find).and_return(disciplinary_card) }

    it "should delete the user" do
      delete :destroy, id: 1
      response.status.should eq(204)
      response.body.should be_blank
    end

    context "doesn't find disciplinary card" do
      before { DisciplinaryCard.stub(:find).and_return(nil) }

      it "should return status 400" do
        delete :destroy, id: 1
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end
end
