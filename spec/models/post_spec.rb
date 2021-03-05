require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "正常系" do
    context "投稿が正常に入力されている時" do
      it"postが正常に作成できること" do
        user = User.create(name: "𓎡𓃭𓇋𓍯𓏤𓄿𓏏𓂋𓄿", avatar: "/cleopatra.png")
        post = Post.new(user_id: user.id, body: "こんにちは")
        expect(post).to be_valid
      end
    end
  end
  describe "異常系" do
    context "bodyが空白の時" do
      it "postの作成が失敗する" do
        user = User.create(name: "𓎡𓃭𓇋𓍯𓏤𓄿𓏏𓂋𓄿", avatar: "/cleopatra.png")
        post = Post.new(user_id: user.id, body: "")
        post.valid?
        expect(post.errors[:body]).to include("can't be blank")
      end
    end
  end
end
