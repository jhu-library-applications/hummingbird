# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User pages', type: :system do # rubocop:disable Metrics/BlockLength
  let(:user) { create(:user) }

  before do
    driven_by(:selenium_chrome_headless)

    visit root_path
  end

  it 'has a login button' do
    expect(page).to have_content('Log in')
  end

  it 'has a register button' do
    expect(page).to have_content('Register')
  end

  it 'has a registration form' do
    click_on 'Register'
    expect(page).to have_content('Sign up')
  end

  it 'can sign up a new user' do # rubocop:disable RSpec/ExampleLength
    click_on 'Register'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_on 'Sign up'
    click_on 'Log out'

    click_link 'Log in'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log in'
    expect(page).to have_content('Log out')
  end
end
