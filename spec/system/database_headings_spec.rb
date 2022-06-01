# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Heading CRUD Operations', type: :system do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:database) { FactoryBot.create(:database) }
  let(:database_heading) { FactoryBot.create(:database_heading) }
  let(:heading) { FactoryBot.create(:heading) }
  let(:category) { FactoryBot.create(:category) }
  let(:subcategory) { FactoryBot.create(:subcategory) }

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path

    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'can create a database heading' do
    database.save!
    heading.save!
    visit '/database_headings'

    click_on 'New database heading'
    select database.name, from: 'Database'
    select heading.label, from: 'Heading'
    click_on 'Create Database heading'

    expect(page).to have_content('Database heading was successfully created.')
  end

  it 'can update a database heading' do
    database_heading.save!
    visit '/database_headings'

    click_on 'Edit this database heading'
    click_on 'Update Database heading'

    expect(page).to have_content('Database heading was successfully updated.')
  end

  it 'can delete a database heading' do
    database_heading.save!
    visit '/database_headings'

    click_on 'Show this database heading'
    click_on 'Destroy this database_heading'

    expect(page).to have_content('Database heading was successfully destroyed.')
  end
end
