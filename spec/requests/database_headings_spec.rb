# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/database_headings', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:database_heading) { FactoryBot.create(:database_heading) }
  let(:heading) { FactoryBot.create(:heading) }
  let(:subheading) { FactoryBot.create(:subheading) }
  let(:database) { FactoryBot.create(:database) }

  let(:required_attributes) do
    { jhu_id: database.jhu_id, database_id: database.id, heading_id: heading.id, subheading_id: subheading.id }
  end

  let(:updated_attributes) do
    { jhu_id: "JHU#{FFaker::Lorem.characters(5)}", database_id: database.id, heading_id: heading.id, subheading_id: subheading.id }
  end

  before do
    sign_in user
    [database, heading, subheading, database_heading].each(&:save!)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get database_headings_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get database_heading_url(database_heading)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_database_heading_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_database_heading_url(database_heading)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new DatabaseHeading' do
        expect do
          post database_headings_url, params: { database_heading: required_attributes }
        end.to change(DatabaseHeading, :count).by(1)
      end

      it 'redirects to the created database_heading' do
        post database_headings_url, params: { database_heading: required_attributes }
        expect(response).to redirect_to(database_heading_url(DatabaseHeading.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new DatabaseHeading' do
        allow_any_instance_of(DatabaseHeading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        put database_heading_url(database_heading), params: { database_heading: { id: '1' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        allow_any_instance_of(DatabaseHeading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance
        post database_headings_url, params: { database_heading: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested database_heading' do
        patch database_heading_url(database_heading), params: { database_heading: updated_attributes }
        database_heading.reload
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the database_heading' do
        patch database_heading_url(database_heading), params: { database_heading: updated_attributes }
        database_heading.reload
        expect(response).to redirect_to(database_heading_url(database_heading))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        allow_any_instance_of(DatabaseHeading).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        patch database_heading_url(database_heading), params: { database_heading: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested database_heading' do
      expect do
        delete database_heading_url(database_heading)
      end.to change(DatabaseHeading, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete database_heading_url(database_heading)
      expect(response).to redirect_to(database_headings_url)
    end
  end
end
