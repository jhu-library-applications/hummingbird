# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/access_restriction_types', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:access_restriction_type) { FactoryBot.create(:access_restriction_type) }
  let(:required_attributes) do
    { type_label: access_restriction_type.type_label, note: access_restriction_type.note, private: access_restriction_type.private }
  end

  before do
    sign_in user
    access_restriction_type.save!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get access_restriction_types_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get access_restriction_type_url(access_restriction_type)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_access_restriction_type_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_access_restriction_type_url(access_restriction_type)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new AccessRestrictionType' do
        expect do
          post access_restriction_types_url, params: { access_restriction_type: { label: FFaker::Education.major } }
        end.to change(AccessRestrictionType, :count).by(1)
      end

      it 'redirects to the created access_restriction_type' do
        post access_restriction_types_url, params: { access_restriction_type: { label: FFaker::Education.major } }
        expect(response).to redirect_to(access_restriction_type_url(AccessRestrictionType.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new AccessRestrictionType' do
        allow_any_instance_of(AccessRestrictionType).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        put access_restriction_type_url(access_restriction_type), params: { access_restriction_type: { id: '1' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        allow_any_instance_of(AccessRestrictionType).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance
        post access_restriction_types_url, params: { access_restriction_type: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested access_restriction_type' do
        patch access_restriction_type_url(access_restriction_type), params: { access_restriction_type: access_restriction_type.attributes }
        access_restriction_type.reload
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the access_restriction_type' do
        patch access_restriction_type_url(access_restriction_type), params: { access_restriction_type: access_restriction_type.attributes }
        access_restriction_type.reload
        expect(response).to redirect_to(access_restriction_type_url(access_restriction_type))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        allow_any_instance_of(AccessRestrictionType).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        patch access_restriction_type_url(access_restriction_type), params: { access_restriction_type: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested access_restriction_type' do
      expect do
        delete access_restriction_type_url(access_restriction_type)
      end.to change(AccessRestrictionType, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete access_restriction_type_url(access_restriction_type)
      expect(response).to redirect_to(access_restriction_types_url)
    end
  end
end
