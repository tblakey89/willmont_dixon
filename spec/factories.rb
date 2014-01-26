FactoryGirl.define do
  factory :pre_enrolment_test do
    name "Pre-enrolment Test"
  end

  factory :section do
    name "This is a question"
    order 1
    pre_enrolment_test
  end

  factory :user do

  end

  factory :disciplinary_card do
    location "Test"
    colour "Green"
    reason "Test"
    user
  end
end
