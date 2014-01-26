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
end
