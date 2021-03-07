require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe '正常系' do
    context "ファラオが日本語を発した時" do
      it 'ヒエログリフになる' do
        visit new_user_session_path
        expect(page).to have_content 'こんにちはファラオ'
        click_button '𓏤𓎛𓄿𓂋𓄿𓍯𓎛𓃭𓍯𓎼𓇋𓈖'
        expect(current_path).to eq root_path
        fill_in 'post_body', with: '今日はいい天気'
        click_button '𓋴𓇋𓈖𓂧'
        expect(page).to have_content '𓎡𓇋𓅱𓎛𓄿𓇋𓇋𓏏𓇋𓈖𓎡𓇋'
      end
    end
    context "ファラオがアルファベットを発した時" do
      it 'ヒエログリフになる' do
        visit new_user_session_path
        expect(page).to have_content 'こんにちはファラオ'
        click_button '𓏤𓎛𓄿𓂋𓄿𓍯𓎛𓃭𓍯𓎼𓇋𓈖'
        expect(current_path).to eq root_path
        fill_in 'post_body', with: 'kyouhaiitenki'
        click_button '𓋴𓇋𓈖𓂧'
        expect(page).to have_content '𓎡𓇋𓍯𓅱𓎛𓄿𓇋𓇋𓏏𓇋𓈖𓎡𓇋'
      end
    end
    context "ファラオが記号しか発さなかった時" do
      it '空白を表すヒエログリフが表示される' do
        visit new_user_session_path
        expect(page).to have_content 'こんにちはファラオ'
        click_button '𓏤𓎛𓄿𓂋𓄿𓍯𓎛𓃭𓍯𓎼𓇋𓈖'
        expect(current_path).to eq root_path
        fill_in 'post_body', with: '!!!!!!!!!!'
        click_button '𓋴𓇋𓈖𓂧'
        expect(page).to have_content '𓋴𓏤𓄿𓎡𓇋'
      end
    end
  end
  describe '異常系' do
    context "ファラオが数字を入力した時" do
      it 'エラーメッセージが表示される' do
        visit new_user_session_path
        expect(page).to have_content 'こんにちはファラオ'
        click_button '𓏤𓎛𓄿𓂋𓄿𓍯𓎛𓃭𓍯𓎼𓇋𓈖'
        expect(current_path).to eq root_path
        fill_in 'post_body', with: '123456'
        click_button '𓋴𓇋𓈖𓂧'
        expect(page).to have_content '𓏤𓃭𓊃 𓅱𓂋𓇋𓏏𓇋 𓄿𓃭𓆑𓄿𓃀𓇋𓏏 𓍯𓂋 𓆓𓄿𓏤𓄿𓈖𓇋𓋴𓇋'
      end
    end
    context "ファラオが空文字を入力した時" do
      it 'エラーメッセージが表示される' do
        visit new_user_session_path
        expect(page).to have_content 'こんにちはファラオ'
        click_button '𓏤𓎛𓄿𓂋𓄿𓍯𓎛𓃭𓍯𓎼𓇋𓈖'
        expect(current_path).to eq root_path
        fill_in 'post_body', with: ''
        click_button '𓋴𓇋𓈖𓂧'
        expect(page).to have_content '𓏤𓃭𓊃 𓅱𓂋𓇋𓏏𓇋 𓄿𓃭𓆑𓄿𓃀𓇋𓏏 𓍯𓂋 𓆓𓄿𓏤𓄿𓈖𓇋𓋴𓇋'
      end
    end
  end
end
