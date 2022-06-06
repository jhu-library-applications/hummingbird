# frozen_string_literal: true

# this class creates an object that enables people to use the site in an
# authoritative fashion
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, inclusion: { in: %w[reader editor admin] }

  %w[reader editor admin].each do |a|
    define_method(a) do
      role == a
    end
  end
end
