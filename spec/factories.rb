FactoryGirl.define do
  factory :course do
    title "Math"
    description "Do math stuff. Algebra and shit."
    course_url "www.example.com/math"
    start_date Date.today
  end
end