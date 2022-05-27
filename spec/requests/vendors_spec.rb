# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Vendors', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:vendor) { FactoryBot.create(:vendor) }

  before do
    sign_in user
  end

  # Create

  describe 'POST /vendors' do
    it 'returns 302 if created' do
      post vendors_path, params: { vendor: { brand_name: '' } }

      expect(response).to have_http_status(:found)
    end

    it 'returns unprocessable entity if given bad params' do
      allow_any_instance_of(Vendor).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

      post vendors_path, params: { vendor: { brand_name: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Read

  describe 'GET /vendors' do
    it 'returns 200 if successful' do
      get vendors_path
      expect(response).to have_http_status(:ok)
    end
  end

  # Update

  describe 'PUT /vendors/1' do
    it 'returns 302 if updated' do
      put vendor_path(vendor), params: { vendor: { brand_name: FFaker::Company.name } }
      expect(response).to have_http_status(:found)
    end

    it 'returns unprocessable entity if given bad params' do
      vendor.save!

      allow_any_instance_of(Vendor).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

      put "/vendors/#{vendor.id}", params: { vendor: { id: '1' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Delete

  describe 'DELETE /vendors/1' do
    it 'returns 302 if successfull' do
      vendor.save!

      delete "/vendors/#{vendor.id}", params: { vendor: { id: '1' } }

      expect(response).to have_http_status(:found)
    end
  end
end
