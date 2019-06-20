require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'test1@example.com')
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end

    context 'ユーザーAがログインしている時' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'test1@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end
    context 'ユーザーBがログインしている時' do
      before do 
        FactoryBot.create(:user, name: 'ユーザーB', email: 'test2@example.com')
        visit login_path
        fill_in 'メールアドレス', with: 'test2@example.com'
        fill_in 'パスワード', with: 'password'
        click_button
      end

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end
end