RSpec.describe 'UserLogins', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'ログイン'
  end

  it 'allows a user to log in' do
    expect(page).to have_content 'ログインしました'
  end
end
