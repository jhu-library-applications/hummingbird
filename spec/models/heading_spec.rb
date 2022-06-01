# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heading, type: :model do
  let(:heading) { FactoryBot.create(:heading) }

  describe 'getting a label for a heading' do
    it 'can get a formatted label' do
      expect(heading.label).to eq("#{heading.category.label} – #{heading.subcategory.label}")
    end
  end
end
