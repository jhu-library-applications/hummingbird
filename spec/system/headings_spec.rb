# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Heading CRUD Operations', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:heading) { FactoryBot.create(:heading) }
  let(:category) { FactoryBot.create(:category) }
  let(:subcategory) { FactoryBot.create(:subcategory) }

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path

    category.save!
    subcategory.save!

    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'can create a heading' do
    visit '/headings'

    click_on 'New heading'
    select category.label, from: 'Category'
    select subcategory.label, from: 'Subcategory'
    click_on 'Create Heading'

    expect(page).to have_content('Heading was successfully created.')
  end

  it 'can update a heading' do
    heading.save!
    visit '/headings'
    click_on 'Edit this heading'
    select category.label, from: 'Category'
    select subcategory.label, from: 'Subcategory'
    click_on 'Update Heading'

    expect(page).to have_content('Heading was successfully updated.')
  end

  it 'can delete heading' do
    heading.save!
    visit '/headings'
    click_on 'Show this heading'
    click_on 'Destroy this heading'

    expect(page).to have_content('Heading was successfully destroyed.')
  end
end
