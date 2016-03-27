class Contact < ApplicationRecord
  
  has_many :article_contacts
  has_many :articles, through: :article_contacts
  has_one :business

  def name
	  "#{first_name} #{last_name}".to_s
  end

  def self.tokens(query)
    contacts = where("email ilike ?", "%#{query}%")
    if contacts.empty?
      [{id: "<<<#{query}>>>", email: "Email: \"#{query}\""}]
    else
      contacts
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(email: $1).id }
    tokens.split(',')
  end
  
  

end
