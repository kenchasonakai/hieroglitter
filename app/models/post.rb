class Post < ApplicationRecord
  validates :body, presence: true
  validates :body, length: { maximum: 140 }
  validates :body, format: { with: /[亜-熙ぁ-んァ-ヶa-zA-z!?]*/, message: "𓍯𓈖𓃭𓇋 𓅱𓋴𓇋 𓄿𓃭𓏤𓎛𓄿𓃀𓇋𓏏 𓍯𓂋 𓆓𓄿𓏤𓄿𓈖𓇋𓋴𓇋 𓎛𓇋𓂋𓄿𓎼𓄿𓈖𓄿 𓄿𓈖𓂧 𓎡𓄿𓏏𓄿𓎡𓄿𓈖𓄿" }
  belongs_to :user
end
