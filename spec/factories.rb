FactoryGirl.define do
  factory :user do
    email "teacher@teachers.com"
    password "ILOVESCHOOL"
  end

  factory :course do
    name "Latin"
    starting_points 50
    total_points 75
  end

  factory :student do
    first_name "Lily"
    last_name "Ross Taylor"
    association :course
  end

  factory :comment do
    message "Good contribution"
    association :student
  end

end
