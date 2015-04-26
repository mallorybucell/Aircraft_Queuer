FactoryGirl.define do
  factory :aircraft do
    size { ["small", "large"].sample }
    kind { ["passenger", "cargo"].sample }
  end

end
