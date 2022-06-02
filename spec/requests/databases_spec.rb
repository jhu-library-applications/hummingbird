# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/databases', type: :request do
  let(:vendor) { FactoryBot.create(:vendor) }
  let(:database) { FactoryBot.create(:database) }
  let(:user) { FactoryBot.create(:user) }
  let(:required_attributes) do
    { name: FFaker::Company.name,
      jhu_id: "JHU#{FFaker::Lorem.characters(5)}",
      url: FFaker::Internet.http_url,
      vendor_id: vendor.id }
  end

  before do
    sign_in user
    vendor.save!
    database.save!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get databases_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get database_url(database)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_database_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_database_url(database)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Database' do
        expect do
          post databases_url, params: { database: required_attributes }
        end.to change(Database, :count).by(1)
      end

      it 'redirects to the created database' do
        post databases_url, params: { database: required_attributes }
        expect(response).to redirect_to(database_url(Database.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Database' do
        allow_any_instance_of(Database).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        put database_url(database), params: { database: { id: '1' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        allow_any_instance_of(Database).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance
        post databases_url, params: { database: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested database' do
        patch database_url(database), params: { database: database.attributes }
        database.reload
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the database' do
        patch database_url(database), params: { database: database.attributes }
        database.reload
        expect(response).to redirect_to(database_url(database))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        allow_any_instance_of(Database).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        patch database_url(database), params: { database: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested database' do
      expect do
        delete database_url(database)
      end.to change(Database, :count).by(-1)
    end

    it 'redirects to the databases list' do
      delete database_url(database)
      expect(response).to redirect_to(databases_url)
    end
  end
end
