FactoryBot.define do
  factory :user do |c|
    c.name {"test@test.com"}
    c.email {"test@test.com"}
    c.password {"password"}
    c.password_confirmation {"password"}
  end

  factory :valid_attributes, class: User do |c|
    c.name {"haivan"}
    c.email {"notadmin@test.com"}
    c.password {"password"}
    c.password_confirmation {"password"}
  end

  factory :invalid_attributes, class: User do |c|
    c.name {"nnnnnnnnnnnn"}
    c.email {"trainer@test.com"}
    c.password {"password"}
    c.password_confirmation {"password"}
  end

  factory :new_attributes, class: User do |c|
    c.name {"new user"}
    c.email {"new_user@test.com"}
    c.password {"password"}
    c.password_confirmation {"password"}
  end
end