# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/subcategories', type: :request do
  let(:vendor) { FactoryBot.create(:vendor) }
  let(:subcategory) { FactoryBot.create(:subcategory) }
  let(:user) { FactoryBot.create(:user) }
  let(:required_attributes) do
    { label: FFaker::Education.major }
  end

  before do
    sign_in user
    vendor.save!
    subcategory.save!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get subcategories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get subcategory_url(subcategory)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_subcategory_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_subcategory_url(subcategory)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Subcategory' do
        expect do
          post subcategories_url, params: { subcategory: required_attributes }
        end.to change(Subcategory, :count).by(1)
      end

      it 'redirects to the created subcategory' do
        post subcategories_url, params: { subcategory: required_attributes }
        expect(response).to redirect_to(subcategory_url(Subcategory.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Subcategory' do
        allow_any_instance_of(Subcategory).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        put subcategory_url(subcategory), params: { subcategory: { id: '1' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        allow_any_instance_of(Subcategory).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance
        post subcategories_url, params: { subcategory: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested subcategory' do
        patch subcategory_url(subcategory), params: { subcategory: subcategory.attributes }
        subcategory.reload
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the subcategory' do
        patch subcategory_url(subcategory), params: { subcategory: subcategory.attributes }
        subcategory.reload
        expect(response).to redirect_to(subcategory_url(subcategory))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        allow_any_instance_of(Subcategory).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        patch subcategory_url(subcategory), params: { subcategory: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested subcategory' do
      expect do
        delete subcategory_url(subcategory)
      end.to change(Subcategory, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete subcategory_url(subcategory)
      expect(response).to redirect_to(subcategories_url)
    end
  end
end
