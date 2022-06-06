# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/subheadings', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:subheading) { FactoryBot.create(:subheading) }
  let(:required_attributes) do
    { label: subheading.label }
  end

  before do
    sign_in user
    subheading.save!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get subheadings_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get subheading_url(subheading)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_subheading_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_subheading_url(subheading)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Subheading' do
        expect do
          post subheadings_url, params: { subheading: { label: FFaker::Education.major } }
        end.to change(Subheading, :count).by(1)
      end

      it 'redirects to the created subheading' do
        post subheadings_url, params: { subheading: { label: FFaker::Education.major } }
        expect(response).to redirect_to(subheading_url(Subheading.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Subheading' do
        allow_any_instance_of(Subheading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        put subheading_url(subheading), params: { subheading: { id: '1' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        allow_any_instance_of(Subheading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance
        post subheadings_url, params: { subheading: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested subheading' do
        patch subheading_url(subheading), params: { subheading: { label: FFaker::Education.major } }
        subheading.reload
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the subheading' do
        patch subheading_url(subheading), params: { subheading: { label: FFaker::Education.major } }
        subheading.reload
        expect(response).to redirect_to(subheading_url(subheading))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        allow_any_instance_of(Subheading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        patch subheading_url(subheading), params: { subheading: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested subheading' do
      expect do
        delete subheading_url(subheading)
      end.to change(Subheading, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete subheading_url(subheading)
      expect(response).to redirect_to(subheadings_url)
    end
  end
end
