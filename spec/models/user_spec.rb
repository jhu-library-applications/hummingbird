# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new(email: 'test@example.com', password: 'password') }

  it 'is valid with a email and password' do
    expect(user).to be_valid
  end
end
