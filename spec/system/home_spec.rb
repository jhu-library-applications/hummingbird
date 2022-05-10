require 'rails_helper'

RSpec.describe "HomePages", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "is accessible" do
    visit root_path
    expect(page).to have_content('hummingbird')
  end
end
