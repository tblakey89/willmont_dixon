require 'spec_helper'

describe Section do
  let(:pre_enrolment_test) { FactoryGirl.create(:pre_enrolment_test) }
  before { @section = pre_enrolment_test.sections.build(name: "The test", order: 1) }

  subject { @section }

  it { should respond_to(:name) }
  it { should respond_to(:order) }
  it { should respond_to(:work_at_height) }
  it { should respond_to(:scaffolder) }
  it { should respond_to(:ground_worker) }
  it { should respond_to(:operate_machinery) }
  it { should respond_to(:lift_loads) }
  it { should respond_to(:young) }
  it { should respond_to(:supervisor) }
  it { should respond_to(:questions) }
  it { should respond_to(:videos) }
  it { should respond_to(:pre_enrolment_test) }
  it { should be_valid }

  describe "the name should be present" do
    before { @section.name = "" }
    it { should_not be_valid }
  end

  describe "the name should be unique" do
    before do
      section2 = @section.clone
      section2.order = 2
      section2.save
    end

    it { should_not be_valid }
  end

  describe "the order should be present" do
    before { @section.order = nil }
    it { should_not be_valid }
  end

  describe "the order should be unique" do
    before do
      section2 = @section.clone
      section2.name = "That other section"
      section2.save
    end

    it { should_not be_valid }
  end

  describe "#correct?" do
    before { @section.save }
    let(:question) { FactoryGirl.create(:question, section: @section, pre_enrolment_test: @section.pre_enrolment_test) }
    let(:question2) { FactoryGirl.create(:question, section: @section, pre_enrolment_test: @section.pre_enrolment_test, answer: 3, name: "Other question") }
    let(:answers) { { question.id.to_s => "2", question2.id.to_s => "3" } }

    it "should return true as both questions correct" do
      @section.correct?(answers).should eql(true)
    end

    describe "one question wrong" do
      let(:answers) { { question.id.to_s => "2", question2.id.to_s => "4" } }

      it "should return false as one question is wrong" do
        @section.correct?(answers).should eql(false)
      end
    end

    describe "two questions wrong" do
      let(:answers) { { question.id.to_s => "1", question2.id.to_s => "4" } }

      it "should return false as two questions are wrong" do
        @section.correct?(answers).should eql(false)
      end
    end

    describe "when the id is not an id" do
      let(:answers) { { question.id.to_s => "hello", question2.id.to_s => "4" } }

      it "should return false as not a valid question" do
        @section.correct?(answers).should eql(false)
      end
    end
  end

  describe "#question_number" do
    it "should return 1 on first call, then 2" do
      @section.question_number.should eql 1
      @section.question_number.should eql 2
    end
  end
end
