# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category CRUD Operations', type: :system do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:vendor) { FactoryBot.create(:vendor) }
  let(:database) { FactoryBot.create(:database) }
  let(:heading) { FactoryBot.create(:heading) }
  let(:category) { FactoryBot.create(:category) }
  let(:subcategory) { FactoryBot.create(:subcategory) }
  let(:database_heading) { FactoryBot.create(:database_heading) }

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path

    subcategory.save!

    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'can create a subcategory' do
    visit '/subcategories'

    click_on 'New subcategory'
    fill_in 'Label', with: FFaker::Education.major

    click_on 'Create Subcategory'

    expect(page).to have_content('Subcategory was successfully created.')
  end

  it 'can update a subcategory' do
    visit '/subcategories'

    click_on 'Edit this subcategory'
    fill_in 'Label', with: FFaker::Company.name
    click_on 'Update Subcategory'

    expect(page).to have_content('Subcategory was successfully updated.')
  end

  it 'can delete subcategory' do
    visit '/subcategories'
    click_on 'Show this subcategory'
    click_on 'Destroy this subcategory'

    expect(page).to have_content('Subcategory was successfully destroyed.')
  end
end
