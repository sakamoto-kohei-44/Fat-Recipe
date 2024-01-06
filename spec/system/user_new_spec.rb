require 'rails_helper'

RSpec.describe 'UserRegistrations', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a user to sign up' do
    visit new_user_path

    fill_in 'user[name]', with: 'テストユーザー'
    fill_in 'user[email]', with: 'test@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_button '登録'

    expect(page).to have_content '新規登録しました。'
  end
end
