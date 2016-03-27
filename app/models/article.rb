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
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank
  has_many :article_contacts
  has_many :contacts, through: :article_contacts
  accepts_nested_attributes_for :contacts, reject_if: proc { |attributes| attributes.any? {|k,v| v.blank?} }
  attr_reader :contact_tokens
  

  validates :name, presence: true
  validates_length_of :content, minimum: 50, too_short: "your content must be at least 50 characters"
  
  def contact_tokens=(tokens)
    self.contact_ids = Contact.ids_from_tokens(tokens)
  end
 
  
  private
    def content_count
      content.scan(/\w+/) unless content.blank?
    end


end