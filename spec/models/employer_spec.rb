require 'spec_helper'

describe Employer do
  before { @employer = Employer.new(company_name: "test", address_line_1: "test", postal_code: "CB6 2JX", contact_number: "07981195131") }

  subject { @employer }

  it { should respond_to(:company_name) }
  it { should respond_to(:address_line_1) }
  it { should respond_to(:address_line_2) }
  it { should respond_to(:city) }
  it { should respond_to(:region) }
  it { should respond_to(:postal_code) }
  it { should respond_to(:user) }
  it { should be_valid }

  describe "name should be presen" do
    before { @employer.company_name = "" }
    it { should_not be_valid }
  end

  describe "address_line_1" do
    before { @employer.address_line_1 = "" }
    it { should_not be_valid }
  end

  describe "postal_code" do
    before { @employer.postal_code = "" }
    it { should_not be_valid }
  end
end
