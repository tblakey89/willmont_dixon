require 'spec_helper'

describe Api::SectionsController do
  let(:section) { double(Section, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, save: true, update_attributes: true, destroy: true) }
  let(:sections) { double(Section, find: section, new: section) }
  let(:json) { { format: :json, pre_enrolment_test_id: 1, section: { name: "Test", order: 1 } } }

  describe "#index" do
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, name: "Test", sections: [section]) } }

    it "populates an array of sections" do
      get :index, pre_enrolment_test_id: 1, format: :json
      assigns(:sections).should eq([section])
    end

    context "with render views" do
      render_views

      it "renders the index view" do
        get :index, pre_enrolment_test_id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body).first
        result[section.class.name.downcase]['id'].should eql(1)
        result[section.class.name.downcase]['name'].should eql("Test")
        result[section.class.name.downcase]['order'].should eql(1)
      end
    end
  end

  describe "#show" do
    before do
      PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, sections: sections) }
    end

    it "assigns a section" do
      get :show, pre_enrolment_test_id: 1, id: 1, format: :json
      assigns(:section).should eq(section)
    end

    context "with render views" do
      render_views

      it "renders the show view" do
        get :show, pre_enrolment_test_id: 1, id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result[section.class.name.downcase]['id'].should eql(1)
        result[section.class.name.downcase]['name'].should eql("Test")
        result[section.class.name.downcase]['order'].should eql(1)
      end
    end
  end

  describe "#create" do
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, sections: sections) } }

    it "assigns a section" do
      post :create, json
      assigns(:section).should eq(section)
    end

    it "renders the show view" do
      post :create, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:section) { double(Section, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, save: false) }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#update" do
    let(:json) { { format: :json, pre_enrolment_test_id: 1, id: 1, section: { name: "Test", order: 1 } } }
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, sections: sections) } }

    it "assigns a section" do
      put :update, json
      assigns(:section).should eq(section)
    end

    it "renders the show view" do
      put :update, json
      response.status.should eq(200)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:section) { double(Section, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, update_attributes: false) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end

    context "with no section" do
      let(:sections) { double(Section, find: nil) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end

  describe "#destroy" do
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, sections: sections) } }

    context "section exists" do

      it "should delete the section" do
        delete :destroy, pre_enrolment_test_id: 1, id: 1
        response.status.should eq(204)
        response.body.should be_blank
      end
    end

    context "doesn't find section" do
      let(:sections) { double(Section, find: nil) }

      it "should return status 400" do
        delete :destroy, pre_enrolment_test_id: 1, id: 1
        response.status.should eq(400)
        response.body.should be_blank
      end
    end
  end
end
