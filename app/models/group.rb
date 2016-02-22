class Group < ApplicationRecord
  belongs_to :business
  has_many :memberships
  has_many :users, through: :memberships
end
