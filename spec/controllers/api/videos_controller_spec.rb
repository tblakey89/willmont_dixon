require 'spec_helper'

describe Api::VideosController do
  let(:video) { double(Video, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, section_id: 1, section: double(Section, name: "Test"), save: true, update_attributes: true, destroy: true, extension_valid?: true) }
  let(:videos) { double(Video, find: video, new: video) }
  let(:json) { { format: :json, pre_enrolment_test_id: 1, video: { name: "Test", order: 1, section_id: 1, answer1: "Test", answer2: "Test2", answer3: "Test3", answer4: "Test4", answer: 1 } } }

  before { sign_in_user }

  describe "#index" do
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, name: "Test", videos: [video]) } }

    it "populates an array of videos" do
      get :index, pre_enrolment_test_id: 1, format: :json
      assigns(:videos).should eq([video])
    end

    context "with render views" do
      render_views

      it "renders the index view" do
        get :index, pre_enrolment_test_id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body).first
        result[video.class.name.downcase]['id'].should eql(1)
        result[video.class.name.downcase]['name'].should eql("Test")
        result[video.class.name.downcase]['order'].should eql(1)
      end
    end
  end

  describe "#show" do
    before do
      PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, videos: videos) }
    end

    it "assigns a video" do
      get :show, pre_enrolment_test_id: 1, id: 1, format: :json
      assigns(:video).should eq(video)
    end

    context "with render views" do
      render_views

      it "renders the show view" do
        get :show, pre_enrolment_test_id: 1, id: 1, format: :json
        response.should be_success
        result = JSON.parse(response.body)
        result[video.class.name.downcase]['id'].should eql(1)
        result[video.class.name.downcase]['name'].should eql("Test")
        result[video.class.name.downcase]['order'].should eql(1)
      end
    end
  end

  describe "#create" do
    before do
      PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, videos: videos) }
      controller.params[:file].stub(:original_filename).and_return(".mp4")
      File.stub(:open).and_return(true)
    end

    it "assigns a video" do
      post :create, json
      assigns(:video).should eq(video)
    end

    it "renders the show view" do
      post :create, json
      response.status.should eq(201)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:video) { double(Video, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, save: false, errors: "Test") }

      it "renders nothing" do
        post :create, json
        response.status.should eq(400)
      end
    end
  end

  describe "#update" do
    let(:json) { { format: :json, pre_enrolment_test_id: 1, id: 1, video: { name: "Test", order: 1 } } }
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, videos: videos) } }

    it "assigns a video" do
      put :update, json
      assigns(:video).should eq(video)
    end

    it "renders the show view" do
      put :update, json
      response.status.should eq(200)
      response.should render_template("show")
    end

    context "invalid information" do
      let(:video) { double(Video, id: 1, name: "Test", order: 1, pre_enrolment_test_id: 1, update_attributes: false, errors: "Test") }

      it "renders nothing" do
        put :update, json
        response.status.should eq(400)
      end
    end

    context "with no video" do
      let(:videos) { double(Video) }
      before { videos.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

      it "renders nothing" do
        put :update, json
        response.status.should eq(404)
        response.body.should be_blank
      end
    end
  end

  describe "#destroy" do
    before { PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, id: 1, videos: videos) } }

    context "video exists" do

      it "should delete the video" do
        delete :destroy, pre_enrolment_test_id: 1, id: 1
        response.status.should eq(204)
        response.body.should be_blank
      end
    end

    context "doesn't find video" do
      let(:videos) { double(Video) }
      before { videos.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

      it "should return status 404" do
        delete :destroy, pre_enrolment_test_id: 1, id: 1
        response.status.should eq(404)
        response.body.should be_blank
      end
    end
  end

  describe "#and_questions" do
    before do
      PreEnrolmentTest.stub(:find) { double(PreEnrolmentTest, videos: videos) }
    end

    it "assigns a video" do
      get :and_questions, pre_enrolment_test_id: 1, id: 1, format: :json
      assigns(:video).should eq(video)
    end

    it "renders the show view" do
      get :and_questions, pre_enrolment_test_id: 1, id: 1, format: :json
      response.should be_success
      response.should render_template("and_questions")
    end
  end
end
