require 'spec_helper'

describe DisciplinaryCard do
  before { @disciplinary_card = DisciplinaryCard.new(user_id: 1,
                                                   location: "Test",
                                                   reason: "Test",
                                                   colour: "Green") }

  subject { @disciplinary_card }

  it { should respond_to(:location) }
  it { should respond_to(:reason) }
  it { should respond_to(:colour) }
  it { should respond_to(:user) }
  it { should be_valid }

  describe "location should be present" do
    before { @disciplinary_card.location = "" }
    it { should_not be_valid }
  end

  describe "reason should be present" do
    before { @disciplinary_card.reason = "" }
    it { should_not be_valid }
  end

  describe "type should be present" do
    before { @disciplinary_card.colour = "" }
    it { should_not be_valid }
  end

  describe "type should be valid" do
    before { @disciplinary_card.colour = "orange" }
    it { should_not be_valid }
  end
end
