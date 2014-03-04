FactoryGirl.define do
  factory :pre_enrolment_test do
    name "Pre-enrolment Test"
  end

  factory :section do
    name "This is a question"
    order 1
    pre_enrolment_test
  end

  factory :question do
    name "What is 2"
    answer1 "One"
    answer2 "Two"
    answer3 "Three"
    answer4 "Four"
    answer 2
    sequence(:order) { |n| n }
    section
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
