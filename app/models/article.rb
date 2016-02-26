# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  name        :string
#  content     :text
#  business_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Article < ApplicationRecord
  validates :name, presence: true
  validates_length_of :content_count, minimum: 20, too_short: "your content must be at least 20 words"
  
  
  belongs_to :business


  private
    def content_count
      content.scan(/\w+/)
    end


end