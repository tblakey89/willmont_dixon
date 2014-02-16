require 'spec_helper'

describe NextOfKin do
  before { @next_of_kin = NextOfKin.new(first_name: "Test",
                                        last_name: "Testerson",
                                        relationship: "Brother",
                                        address_line_1: "test street",
                                        postcode: "CB6 2JX",
                                        contact_number: "07981195131"
                                       ) }

  subject { @next_of_kin }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:relationship) }
  it { should respond_to(:address_line_1) }
  it { should respond_to(:address_line_2) }
  it { should respond_to(:city) }
  it { should respond_to(:postcode) }
  it { should respond_to(:user) }
  it { should be_valid }

  describe "first_name should be present" do
    before { @next_of_kin.first_name = "" }
    it { should_not be_valid }
  end

  describe "last_name should be present" do
    before { @next_of_kin.last_name = "" }
    it { should_not be_valid }
  end

  describe "relationship should be present" do
    before { @next_of_kin.relationship = "" }
    it { should_not be_valid }
  end

  describe "address_line_1 should be present" do
    before { @next_of_kin.address_line_1 = "" }
    it { should_not be_valid }
  end

  describe "postcode should be present" do
    before { @next_of_kin.postcode = "" }
    it { should_not be_valid }
  end

  describe "postcode should be valid" do
    before { @next_of_kin.postcode = "GGG 666" }
    it { should_not be_valid }
  end
end
