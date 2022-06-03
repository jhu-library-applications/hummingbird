# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Heading-related CRUD Operations', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:vendor) { FactoryBot.create(:vendor) }
  let(:database) { FactoryBot.create(:database) }
  let(:heading) { FactoryBot.create(:heading) }
  let(:subheading) { FactoryBot.create(:subheading) }
  let(:database_heading) { FactoryBot.create(:database_heading) }

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path

    vendor.save!

    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'can create a heading' do
    visit '/headings'

    click_on 'New heading'
    fill_in 'Label', with: FFaker::Education.major

    click_on 'Create Heading'

    expect(page).to have_content('Heading was successfully created.')
  end

  it 'can create a subheading' do
    visit '/subheadings'

    click_on 'New subheading'
    fill_in 'Label', with: FFaker::Education.major

    click_on 'Create Subheading'

    expect(page).to have_content('Subheading was successfully created.')
  end

  it 'can create a database heading' do
    heading.save!
    subheading.save!
    database.save!

    visit '/database_headings'

    click_on 'New database heading'
    click_on 'Create Database heading'
    expect(page).to have_content('Database heading was successfully created.')
  end

  it 'can update a database heading' do
    heading.save!
    subheading.save!
    database.save!
    database_heading.save!
    visit '/database_headings'

    click_on 'Edit this database heading'
    click_on 'Update Database heading'
    expect(page).to have_content('Database heading was successfully updated.')
  end

  it 'can delete a database heading' do
    heading.save!
    subheading.save!
    database.save!
    database_heading.save!
    visit '/database_headings'

    click_on 'Show this database heading'
    click_on 'Destroy this database_heading'

    expect(page).to have_content('Database heading was successfully destroyed.')
  end
end
