# == Schema Information
#
# Table name: businesses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Business < ApplicationRecord
  has_many :groups
  has_many :articles
  has_many :contacts
  
  validates :name, presence: true
end
