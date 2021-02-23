class FavoritesController < ApplicationController
  def create
    user = User.first
    @post = Post.find(params[:post_id])
    Favorite.create(user_id: user.id, post_id: @post.id)
    @favorites = @post.favorites.count
  end
end
