# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/access_restrictions', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:access_restriction) { FactoryBot.build(:access_restriction) }
  let(:required_attributes) do
    { access_restriction_type_id: access_restriction.access_restriction_type.id, database_id: access_restriction.database.id, note: access_restriction.note, private_url: FFaker::Internet.http_url }
  end
  let(:unique_required_attributes) do
    { access_restriction_type_id: access_restriction.access_restriction_type.id, database_id: access_restriction.database.id, note: access_restriction.note, private_url: FFaker::Internet.http_url }
  end

  before do
    sign_in user
    access_restriction.save!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get access_restrictions_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get access_restriction_url(access_restriction)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_access_restriction_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_access_restriction_url(access_restriction)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new AccessRestriction' do
        expect do
          post access_restrictions_url, params: { access_restriction: required_attributes }
        end.to change(AccessRestriction, :count).by(1)
      end

      it 'redirects to the created access_restriction' do
        post access_restrictions_url, params: { access_restriction: unique_required_attributes }
        expect(response).to redirect_to(access_restriction_url(AccessRestriction.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new AccessRestriction' do
        allow_any_instance_of(AccessRestriction).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        put access_restriction_url(access_restriction), params: { access_restriction: { id: '1' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        allow_any_instance_of(AccessRestriction).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance
        post access_restrictions_url, params: { access_restriction: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested access_restriction' do
        patch access_restriction_url(access_restriction), params: { access_restriction: access_restriction.attributes }
        access_restriction.reload
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the access_restriction' do
        patch access_restriction_url(access_restriction), params: { access_restriction: access_restriction.attributes }
        access_restriction.reload
        expect(response).to redirect_to(access_restriction_url(access_restriction))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        allow_any_instance_of(AccessRestriction).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        patch access_restriction_url(access_restriction), params: { access_restriction: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested access_restriction' do
      expect do
        delete access_restriction_url(access_restriction)
      end.to change(AccessRestriction, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete access_restriction_url(access_restriction)
      expect(response).to redirect_to(access_restrictions_url)
    end
  end
end
