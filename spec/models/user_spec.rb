# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do
  let(:user) { described_class.new(email: 'test@example.com', password: 'password', role: 'admin') }
  let(:reader_user) { described_class.new(email: 'test1@example.com', password: 'password', role: 'reader') }
  let(:ability) { Ability.new(reader_user) }

  describe 'abilities' do
    it 'can read as reader' do
      expect(ability).to be_able_to(:read, Vendor.new)
    end

    it 'can not destory as reader' do
      expect(ability).not_to be_able_to(:destroy, Vendor.new)
    end
  end

  it 'is valid with a email, password, and role' do
    expect(user).to be_valid
  end
end
