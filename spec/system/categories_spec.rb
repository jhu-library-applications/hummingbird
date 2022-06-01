# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category CRUD Operations', type: :system do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:vendor) { FactoryBot.create(:category) }
  let(:database) { FactoryBot.create(:database) }
  let(:heading) { FactoryBot.create(:heading) }
  let(:category) { FactoryBot.create(:category) }
  let(:subcategory) { FactoryBot.create(:subcategory) }
  let(:database_heading) { FactoryBot.create(:database_heading) }

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path

    category.save!

    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'can create a category' do
    visit '/categories'

    click_on 'New category'
    fill_in 'Label', with: FFaker::Education.major

    click_on 'Create Category'

    expect(page).to have_content('Category was successfully created.')
  end

  it 'can update a category' do
    visit '/categories'

    click_on 'Edit this category'
    fill_in 'Label', with: FFaker::Company.name
    click_on 'Update Category'

    expect(page).to have_content('Category was successfully updated.')
  end

  it 'can delete category' do
    visit '/categories'
    click_on 'Show this category'
    click_on 'Destroy this category'

    expect(page).to have_content('Category was successfully destroyed.')
  end
end
