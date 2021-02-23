class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :body, null: false
      t.string :post_image
      t.references :user, foringkey: true

      t.timestamps
    end
  end
end
