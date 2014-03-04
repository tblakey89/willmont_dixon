require 'spec_helper'

describe Question do
  let(:section) { FactoryGirl.create(:section) }
  before { @question = section.questions.build(name: "This is a good question",
                                               answer1: "This is wrong",
                                               answer2: "This is also wrong",
                                               answer3: "This is the right answer",
                                               answer4: "No not me",
                                               answer: 1,
                                               order: 1,
                                               pre_enrolment_test_id: section.pre_enrolment_test_id) }

  subject { @question }

  it { should respond_to(:name) }
  it { should respond_to(:answer1) }
  it { should respond_to(:answer2) }
  it { should respond_to(:answer3) }
  it { should respond_to(:answer4) }
  it { should respond_to(:answer) }
  it { should respond_to(:order) }
  it { should respond_to(:section) }
  it { should respond_to(:video) }
  it { should respond_to(:pre_enrolment_test) }
  it { should be_valid }

  describe "name should be present" do
    before { @question.name = "" }
    it { should_not be_valid }
  end

  describe "name should be unique" do
    before do
      question2 = @question.clone
      question2.order = 2
      question2.save
    end

    it { should_not be_valid }
  end

  describe "answer1 should be present" do
    before { @question.answer1 = "" }
    it { should_not be_valid }
  end

  describe "answer2 should be present" do
    before { @question.answer2 = "" }
    it { should_not be_valid }
  end

  describe "answer3 should be present" do
    before { @question.answer3 = "" }
    it { should_not be_valid }
  end

  describe "answer4 should be present" do
    before { @question.answer4 = "" }
    it { should_not be_valid }
  end

  describe "answer should be present" do
    before { @question.answer = nil }
    it { should_not be_valid }
  end

  describe "order should be present" do
    before { @question.order = nil }
    it { should_not be_valid }
  end

  describe "order should be unique" do
    before do
      question2 = @question.clone
      question2.name = "This is a different question"
      question2.save
    end
    it { should_not be_valid }
  end
end
