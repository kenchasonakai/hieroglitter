require 'rails_helper'

RSpec.describe User, type: :model do
  describe "正常系" do
    context "nameとavatarが存在する時" do
      it"userが正常に作成されること" do
        user = User.new(name: "𓎡𓃭𓇋𓍯𓏤𓄿𓏏𓂋𓄿", avatar: "/cleopatra.png")
        expect(user).to be_valid
      end
    end
  end
  describe "異常系" do
    context "nameが空の時" do
      it"userが作成されないこと" do
        user = User.new(name: "", avatar: "/cleopatra.png")
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
    end
  end
end
