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
  belongs_to :business
  has_many :attachments
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :name, presence: true
  validates_length_of :content, minimum: 50, too_short: "your content must be at least 50 characters"
  
  
  private
    def content_count
      if content.blank?
        content = nil
      else
        content.scan(/\w+/)
      end
    end


end