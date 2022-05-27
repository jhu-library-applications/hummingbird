# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Vendor CRUD Operations', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:vendor) { FactoryBot.create(:vendor) }

  before do
    driven_by(:selenium_chrome_headless)
    vendor.save!

    visit root_path

    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'can create a vendor' do
    visit '/vendors'

    click_on 'New vendor'
    fill_in 'Brand Name', with: FFaker::Company.name
    click_on 'Create Vendor'

    expect(page).to have_content('Vendor was successfully created.')
  end

  it 'can update a vendor' do
    visit '/vendors'

    click_on 'Edit this vendor'
    fill_in 'Brand Name', with: FFaker::Company.name
    click_on 'Update Vendor'

    expect(page).to have_content('Vendor was successfully updated.')
  end

  it 'can delete vendor' do
    visit '/vendors'
    click_on 'Show this vendor'
    click_on 'Destroy this vendor'

    expect(page).to have_content('Vendor was successfully destroyed.')
  end
end
