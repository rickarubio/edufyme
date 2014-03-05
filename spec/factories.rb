FactoryGirl.define do
  factory :course do
    sequence(:title) { |num| "My name #{num}" }
    sequence(:description) { |num| "My description #{num}" }
    sequence(:course_url) { |num| "My course_url #{num}" }
    sequence(:course_img_url) { |num| "My course_img_url #{num}" }
    sequence(:start_date) { |num| "My start_date #{num}" }
    sequence(:teachers) { |num| "My instructors #{num}" }
  end

  factory :school do
    sequence(:name) { |num| "My school #{num}" }
    sequence(:school_url) { |num| "http://www.school#{num}.edu/" }
    sequence(:school_img_url) { |num| "http://www.schoolimages#{num}.edu/collegepic.jpg" }
  end

  factory :user do
    sequence(:email) { |num| "bob#{num}@example.com" }
    password "password"
  end
end