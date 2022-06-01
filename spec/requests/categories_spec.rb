# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/categories', type: :request do
  let(:vendor) { FactoryBot.create(:vendor) }
  let(:category) { FactoryBot.create(:category) }
  let(:user) { FactoryBot.create(:user) }
  let(:required_attributes) do
    { label: FFaker::Education.major }
  end

  before do
    sign_in user
    vendor.save!
    category.save!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get categories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get category_url(category)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_category_url(category)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post categories_url, params: { category: required_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the created category' do
        post categories_url, params: { category: required_attributes }
        expect(response).to redirect_to(category_url(Category.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        allow_any_instance_of(Category).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        put category_url(category), params: { category: { id: '1' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        allow_any_instance_of(Category).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance
        post categories_url, params: { category: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested category' do
        patch category_url(category), params: { category: category.attributes }
        category.reload
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the category' do
        patch category_url(category), params: { category: category.attributes }
        category.reload
        expect(response).to redirect_to(category_url(category))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        allow_any_instance_of(Category).to receive(:save).and_return(false) # rubocop:disable RSpec/AnyInstance

        patch category_url(category), params: { category: { id: '1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested category' do
      expect do
        delete category_url(category)
      end.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete category_url(category)
      expect(response).to redirect_to(categories_url)
    end
  end
end
