# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/headings', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:heading) { FactoryBot.create(:heading) }
  let(:required_attributes) do
    { label: heading.label }
  end

  before do
    sign_in user
    heading.save!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get headings_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get heading_url(heading)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_heading_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_heading_url(heading)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Heading' do
        expect do
          post headings_url, params: { heading: { label: FFaker::Education.major } }
        end.to change(Heading, :count).by(1)
      end

      it 'redirects to the created heading' do
        post headings_url, params: { heading: { label: FFaker::Education.major } }
        expect(response).to redirect_to(heading_url(Heading.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Heading' do
        allow_any_instance_of(Heading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        put heading_url(heading), params: { heading: { id: '1' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        allow_any_instance_of(Heading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance
        post headings_url, params: { heading: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested heading' do
        patch heading_url(heading), params: { heading: heading.attributes }
        heading.reload
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the heading' do
        patch heading_url(heading), params: { heading: heading.attributes }
        heading.reload
        expect(response).to redirect_to(heading_url(heading))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        allow_any_instance_of(Heading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        patch heading_url(heading), params: { heading: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested heading' do
      expect do
        delete heading_url(heading)
      end.to change(Heading, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete heading_url(heading)
      expect(response).to redirect_to(headings_url)
    end
  end
end
