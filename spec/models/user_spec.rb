require "rails_helper"

RSpec.describe User, :type => :model do
  it "orders by last name" do
    bot1 = User.create!(email: "bot1@gmail.com", password: "123123123")
    bot2 = User.create!(email: "bot2@gmail.com", password: "123123123")

    expect(User.order(:email)).to eq([bot1, bot2])
  end
end
