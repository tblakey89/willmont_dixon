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
  it { should respond_to(:work_at_height) }
  it { should respond_to(:scaffolder) }
  it { should respond_to(:ground_worker) }
  it { should respond_to(:operate_machinery) }
  it { should respond_to(:lift_loads) }
  it { should respond_to(:last_sign_in) }
  it { should respond_to(:next_of_kins) }
  it { should respond_to(:employers) }
  it { should respond_to(:disciplinary_cards) }
  it { should be_valid }

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
