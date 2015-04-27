100.times do
  FactoryGirl.create :aircraft
end

User.create!(email: "user1@example.com", password: "password")
User.create!(email: "user2@example.com", password: "password")