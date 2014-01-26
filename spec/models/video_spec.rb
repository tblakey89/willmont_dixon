require 'spec_helper'

describe Video do
  let(:section) { FactoryGirl.create(:section) }
  before { @video = Video.new(name: "Test", order: 1, section_id: section.id, pre_enrolment_test_id: section.pre_enrolment_test.id) }

  subject { @video }

  it { should respond_to(:name) }
  it { should respond_to(:order) }
  it { should respond_to(:pre_enrolment_test) }
  it { should respond_to(:section) }
  it { should be_valid }

  describe "the name should be present" do
    before { @video.name = "" }
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
end
