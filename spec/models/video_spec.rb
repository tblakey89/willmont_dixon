require 'spec_helper'

describe Video do
  let(:section) { FactoryGirl.create(:section) }
  before { @video = Video.new(name: "Test", order: 1, section_id: section.id, pre_enrolment_test_id: section.pre_enrolment_test.id, show_questions: 2) }

  subject { @video }

  it { should respond_to(:name) }
  it { should respond_to(:order) }
  it { should respond_to(:pre_enrolment_test) }
  it { should respond_to(:show_questions) }
  it { should respond_to(:questions) }
  it { should respond_to(:section) }
  it { should be_valid }

  describe "the name should be present" do
    before { @video.name = "" }
    it { should_not be_valid }
  end

  describe "show questions should be present" do
    before { @video.show_questions = "" }
    it { should_not be_valid }
  end

  describe "the name should be unique" do
    before do
      video2 = @video.clone
      video2.order = 2
      video2.save
    end

    it { should_not be_valid }
  end

  describe "the order should be present" do
    before { @video.order = "" }
    it { should_not be_valid }
  end

  describe "the order should be unique" do
    before do
      video2 = @video.clone
      video2.name = "Test2"
      video2.save
    end

    it { should_not be_valid }
  end

  describe "#extension_valid?" do
    it "should return something for .mp4" do
      @video.extension_valid?(".mp4").should eq(0)
    end

    it "should return nil for .exe" do
      @video.extension_valid?(".exe").should eq(nil)
    end
  end

  describe "#random_questions" do
    before do
      @video.save
      @video.questions.create(name: "test", order: 1, answer1: "no", answer2: "no", answer3: "no", answer4: "yes", answer: 4, section: @video.section, pre_enrolment_test: @video.pre_enrolment_test)
    end

    it "should return a question" do
      @video.random_questions.first.should eql(@video.questions.first)
    end
  end
end
