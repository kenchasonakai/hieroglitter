module ApplicationHelper
  def get_twitter_card_info(page)
    twitter_card = {}
    twitter_card[:url] = 'https://hieroglitter.herokuapp.com/'
    twitter_card[:title] = 'hieroglitter'
    twitter_card[:description] = '𓇋𓈖𓆑𓍯𓂋𓅓𓄿𓏏𓇋𓍯𓈖 𓋴𓎛𓄿𓂋𓇋𓈖𓎼 𓄿𓏤𓏤 𓆑𓍯𓂋 𓏤𓎛𓄿𓂋𓄿𓍯𓎛'
    twitter_card[:image] = 'https://hieroglitter.herokuapp.com/rosetta_stone.png'
    twitter_card[:card] = 'summary'
    twitter_card[:site] = 'hieroglitter'
    return twitter_card
  end
end
