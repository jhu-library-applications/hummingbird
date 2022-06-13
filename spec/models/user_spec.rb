# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do
  let(:user) { described_class.new(email: 'test@example.com', password: 'password', role: 'admin') }

  describe "abilities" do
    it 'has valid permissions' do
      user.update(role: 'reader')
      ability = Ability.new(user)
      expect(ability).to be_able_to(:read, Vendor.new)
      expect(ability).to_not be_able_to(:destroy, Vendor.new)
    end
  end

  it 'is valid with a email, password, and role' do
    expect(user).to be_valid
  end
end
