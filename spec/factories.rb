FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
    banned false
    admin false
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :rating3, class: Rating do
    score 10
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end

  factory :beer2, class: Beer do
    name "anonymous2"
    brewery
    style
  end

  factory :beer3, class: Beer do
    name "anonymous3"
    brewery
    style
  end

  factory :style do
    name "Lager"
    description "Lages is good"
  end

  factory :style2, class: Style do
    name "IPA"
    description "IPA is better"
  end
end