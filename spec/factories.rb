FactoryGirl.define do
  factory :course do
    title "Math"
    description "Do math stuff. Algebra and shit."
    course_url "www.example.com/math"
    start_date Date.today
    school_id 1
    category_id 1
  end

  factory :category do
    id 1
    name "Math"
  end

  factory :school do
    id 1
    name "Hogwarts"
  end
end