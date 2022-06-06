# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new(email: 'test@example.com', password: 'password', role: 'admin') }

  it 'is valid with a email, password, and role' do
    expect(user).to be_valid
  end
end
