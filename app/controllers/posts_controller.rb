class PostsController < ApplicationController
  require 'miyabi'
  require "open-uri"
  require "nokogiri"

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
    change_roman_to_hieroglyphics(roman)
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
  def change_roman_to_hieroglyphics(roman)
    hash = { A: ["1313F"], B: ["130C0"] , C: ["133A1"], D: ["130A7"], E: ["131CB"],
             F: ["13191"], G: ["133BC"], H: ["1339B"], I: ["131CB"], J: ["13193"],
             K: ["133A1"], L: ["130ED"], M: ["13153"], N: ["13216"], O: ["1336F"],
             P: ["133E4"], Q: ["133D8"], R: ["1308B"], S: ["132F4"], T: ["133CF"],
             U: ["13171"], V: ["13191"],W: ["13171"], X: ["133A1", "132F4"], Y: ["131CB"], Z: ["13283"] }
    result = []
    strings = roman.split("")
    strings.each do |string|
      hash[string.to_sym] ? result.push(hash[string.to_sym].map{ |s| s.hex.chr(Encoding::UTF_8)}) : result.push(string)
    end
    return hieroglyphics = result.join().size > 0 ? result.join() : "𓋴𓏤𓄿𓎡𓇋"
  end
end
