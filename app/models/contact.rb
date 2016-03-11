class Contact < ApplicationRecord
  
  has_many :article_contacts
  has_many :articles, through: :article_contacts

  def name
	  "#{first_name} #{last_name}".to_s
  end

end
