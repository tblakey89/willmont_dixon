FactoryGirl.define do
  factory :pre_enrolment_test do
    name "Pre-enrolment Test"
  end

  factory :section do
    name "This is a question"
    order 1
    pre_enrolment_test
  end
end
