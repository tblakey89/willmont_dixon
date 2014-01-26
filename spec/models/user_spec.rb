require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Test",
                            last_name: "Testerson",
                            email: "test_testerson@test.com",
                            role: 1,
                            job: "Builder",
                            health_issues: false,
                            is_supervisor: false,
                            national_insurance: "JG555555G",
                            cscs_number: "234234",
                            cscs_expiry_date: "2014-05-01",
                            contact_number: "07777777777",
                            address_line_1: "Test street",
                            address_line_2: "Test village",
                            city: "Test City",
                            postcode: "CB6 2JX",
                            date_of_birth: "1989-07-02") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:role) }
  it { should respond_to(:job) }
  it { should respond_to(:health_issues) }
  it { should respond_to(:is_supervisor) }
  it { should respond_to(:national_insurance) }
  it { should respond_to(:cscs_expiry_date) }
  it { should respond_to(:cscs_number) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:completed_pre_enrolment) }
  it { should respond_to(:pre_enrolment_due) }
  it { should respond_to(:contact_number) }
  it { should respond_to(:address_line_1) }
  it { should respond_to(:address_line_2) }
  it { should respond_to(:city) }
  it { should respond_to(:postcode) }
  it { should respond_to(:last_sign_in) }
  it { should respond_to(:next_of_kins) }
  it { should respond_to(:disciplinary_cards) }
  it { should be_valid }

  describe "first_name should be present" do
    before { @user.first_name = "" }
    it { should_not be_valid }
  end

  describe "last_name should be present" do
    before { @user.last_name = "" }
    it { should_not be_valid }
  end

  describe "email should be present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "email should be valid" do
    before { @user.email = "test.test.com" }
    it { should_not be_valid }
  end

  describe "email should be unique" do
    before do
      user2 = @user.clone
      user2.national_insurance = "JG222222H"
      user2.cscs_number = "232343242"
      user2.email = user2.email.upcase
      user2.save
    end

    it { should_not be_valid }
  end

  describe "date_of_birth should be present" do
    before { @user.date_of_birth = nil }
    it { should_not be_valid }
  end

  describe "national_insurance should be present" do
    before { @user.national_insurance = "" }
    it { should_not be_valid }
  end

  describe "national_insurance should be in the right format" do
    before { @user.national_insurance = "21321Gjjk" }
    it { should_not be_valid }
  end

  describe "national_insurance should be unique" do
    before do
      user2 = @user.clone
      user2.email = "test2@test.com"
      user2.cscs_number = "2323213"
      user2.save
    end

    it { should_not be_valid }
  end

  describe "cscs_number should be present" do
    before { @user.cscs_number = "" }
    it { should_not be_valid }
  end

  describe "cscs_number should be unique" do
    before do
      user2 = @user.clone
      user2.email = "test2@test.com"
      user2.national_insurance = "AB222222H"
      user2.save
    end

    it { should_not be_valid }
  end

  describe "cscs_expiry_date should be present" do
    before { @user.cscs_expiry_date = nil }
    it { should_not be_valid }
  end

  describe "role should be present" do
    before { @user.role = nil }
    it { should_not be_valid }
  end

  describe "postcode should be present" do
    before { @user.postcode = nil }
    it { should_not be_valid }
  end

  describe "postcode should be valid" do
    before { @user.postcode = "GGG 666" }
    it { should_not be_valid }
  end

  describe "contact_number should be present" do
    before { @user.contact_number = "" }
    it { should_not be_valid }
  end

  describe "contact_number should be valid" do
    before { @user.contact_number = "abcdefjnfdnjjj" }
    it { should_not be_valid }
  end

  describe "card methods" do
    let!(:disciplinary_card) { FactoryGirl.create(:disciplinary_card, user: @user, created_at: DateTime.now) }

    it "should return one green card and no red or yellow cards" do
      @user.green_cards.should eq(1)
      @user.yellow_cards.should eq(0)
      @user.red_cards.should eq(0)
    end

    it "should return one yellow card and no green or red cards" do
      disciplinary_card.colour = "Yellow"
      disciplinary_card.save
      @user.green_cards.should eq(0)
      @user.yellow_cards.should eq(1)
      @user.red_cards.should eq(0)
    end

    it "should return one red card and no green or yellow cards" do
      disciplinary_card.colour = "Red"
      disciplinary_card.save
      @user.green_cards.should eq(0)
      @user.yellow_cards.should eq(0)
      @user.red_cards.should eq(1)
    end

    it "should return no green or yellow or red cards" do
      disciplinary_card.created_at = 2.year.ago
      disciplinary_card.save
      @user.green_cards.should eq(0)
      @user.yellow_cards.should eq(0)
      @user.red_cards.should eq(0)
    end
  end
end
