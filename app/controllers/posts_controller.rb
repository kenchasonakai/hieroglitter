class PostsController < ApplicationController
  require 'miyabi'
  require "open-uri"
  require "nokogiri"
  require 'pharaoh_lang'

  YAHOO_API_ID = Rails.application.credentials.yahoo[:api_id]

  def new
    @post = Post.new
    @posts = Post.includes([:user, :favorites]).order(id: "DESC").page(params[:page]).per(20)
  end
  def create
    @post = @current_user.posts.build(post_params)
    @post.save ? flash[:success] = "𓋴𓅱𓎡𓎡𓇋𓋴𓋴" : flash[:danger] = "𓏤𓃭𓊃 𓅱𓂋𓇋𓏏𓇋 𓄿𓃭𓆑𓄿𓃀𓇋𓏏 𓍯𓂋 𓆓𓄿𓏤𓄿𓈖𓇋𓋴𓇋"
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:body).merge(hieroglyphics: get_hieroglyphics(params[:post][:body]))
  end
  def get_hieroglyphics(body)
    body = change_kanji_to_hiragana(body)
    roman = change_string_to_roman(body)
    return hieroglyph = roman.to_hieroglyph.size > 0 ? roman.to_hieroglyph : "𓋴𓏤𓄿𓎡𓇋"
  end
  def change_kanji_to_hiragana(body)
    return body if !body.is_japanese?
    enc_word = URI.encode_www_form_component(body)
    url = "http://jlp.yahooapis.jp/FuriganaService/V1/furigana?appid=#{YAHOO_API_ID}&sentence=#{enc_word}"
    doc = Nokogiri::HTML(URI.open(url))
    hiragana = doc.xpath('//word/furigana').map{|i| i.text}.join rescue body
    return body = hiragana
  end
  def change_string_to_roman(body)
    get_string = body.split("").map{ |s| s.is_roman? ? s.upcase : s.to_roman.upcase }.join()
  end
end
