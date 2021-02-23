class PostsController < ApplicationController
  require 'miyabi'
  def new
    @post = Post.new
    @posts = Post.all.order(id: "DESC")
  end
  def create
    user_id = (1..5).to_a.sample(1).join().to_i
    user = User.find(user_id)
    @post = user.posts.build(post_params)
    @post.save ? flash[:success] = "𓋴𓅱𓎡𓎡𓇋𓋴𓋴" : flash[:danger] = "𓏤𓃭𓊃 𓅱𓂋𓇋𓏏𓇋 𓄿𓃭𓆑𓄿𓃀𓇋𓏏 𓍯𓂋 𓆓𓄿𓏤𓄿𓈖𓇋𓋴𓇋"
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:body).merge(hieroglyphics: set_hieroglyphics(body: params[:post][:body]))
  end
  def set_hieroglyphics(body: true)
    hash = { A: ["1313F"], B: ["130C0"] , C: ["133A1"], D: ["130A7"], E: ["131CB"],
             F: ["13191"], G: ["133BC"], H: ["1339B"], I: ["131CB"], J: ["13193"],
             K: ["133A1"], L: ["130ED"], M: ["13153"], N: ["13216"], O: ["1336F"],
             P: ["133E4"], Q: ["133D8"], R: ["1308B"], S: ["132F4"], T: ["133CF"],
             U: ["13171"], V: ["13191"],W: ["13171"], X: ["133A1", "132F4"], Y: ["131CB"], Z: ["13283"] }
    result = []
    text_body = body.is_japanese? ? body.to_kanhira : body
    get_string = text_body.is_roman? ? text_body.upcase : text_body.to_roman.upcase
    strings = get_string.split("")
    strings.each do |string|
      hash[string.to_sym] ? result.push(hash[string.to_sym].map{ |s| s.hex.chr(Encoding::UTF_8)}) : result.push(string)
    end
    return result.join()
  end
end
