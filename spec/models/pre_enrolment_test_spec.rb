require 'spec_helper'

describe PreEnrolmentTest do
  before { @pre_enrolment_test = PreEnrolmentTest.new(name: "Pre-enrolment test") }

  subject { @pre_enrolment_test }

  it { should respond_to(:name) }
  it { should respond_to(:sections) }
  it { should respond_to(:questions) }
  it { should be_valid }

  describe "name should be present" do
    before { @pre_enrolment_test.name = "" }
    it { should_not be_valid }
  end

  describe "name should be unique" do
    before do
      test2 = @pre_enrolment_test.clone
      test2.save
    end

    it { should_not be_valid }
  end
end
