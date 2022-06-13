# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Database CRUD Operations', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:vendor) { FactoryBot.create(:vendor) }
  let(:database) { FactoryBot.create(:vendor) }

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path

    vendor.save!
    user.save!
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'can create a database' do
    visit '/databases'

    click_on 'New database'
    fill_in 'JHU ID', with: "JHU#{FFaker::Lorem.characters(5)}"
    fill_in 'Name', with: FFaker::Company.name
    fill_in 'URL', with: FFaker::Internet.http_url
    check('Enable Proxy?', allow_label_click: true)
    fill_in 'Description', with: FFaker::Lorem.paragraph
    fill_in 'Internal Note', with: FFaker::Lorem.paragraph

    click_on 'Create Database'

    expect(page).to have_content('Database was successfully created.')
  end

  it 'can update a database' do
    visit '/databases'

    click_on 'New database'
    fill_in 'JHU ID', with: "JHU#{FFaker::Lorem.characters(5)}"
    fill_in 'Name', with: FFaker::Company.name
    fill_in 'URL', with: FFaker::Internet.http_url
    check('Enable Proxy?', allow_label_click: true)
    fill_in 'Description', with: FFaker::Lorem.paragraph
    fill_in 'Internal Note', with: FFaker::Lorem.paragraph

    click_on 'Create Database'

    visit '/databases'
    click_on 'Edit this database'
    fill_in 'Name', with: FFaker::Company.name
    click_on 'Update Database'

    expect(page).to have_content('Database was successfully updated.')
  end

  it 'can delete database' do
    visit '/databases'
    click_on 'New database'
    fill_in 'JHU ID', with: "JHU#{FFaker::Lorem.characters(5)}"
    fill_in 'Name', with: FFaker::Company.name
    fill_in 'URL', with: FFaker::Internet.http_url
    check('Enable Proxy?', allow_label_click: true)
    fill_in 'Description', with: FFaker::Lorem.paragraph
    fill_in 'Internal Note', with: FFaker::Lorem.paragraph

    click_on 'Create Database'

    visit '/databases'

    click_on 'Show this database'
    click_on 'Destroy this database'

    expect(page).to have_content('Database was successfully destroyed.')
  end
end
