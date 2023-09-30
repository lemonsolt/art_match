require 'rails_helper'

# describe 'ユーザーログイン前のテスト' do
#   describe 'トップ画面のテスト' do
#     before do
#       visit root_path
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/'
#       end
#       it 'ログイン リンクが表示される: ボタンの表示が「ログイン」である'do
#         log_in_link = find_all('a')[4].text
#         expect(log_in_link).to match(/ログイン/)
#       end
#       it 'ログインリンクの内容が正しい' do
#         log_in_link = find_all ('a')[4].text
#         expect(page).to have_link log_in_link, href: gallary_session_path || artist_session_path
#       end
#     end
#   end
# end
