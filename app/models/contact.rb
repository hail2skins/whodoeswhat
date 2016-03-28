class Contact < ApplicationRecord
  
  has_many :article_contacts
  has_many :articles, through: :article_contacts
  has_one :business

  def name
	  "#{first_name} #{last_name}".to_s
  end

  def self.tokens(query)
    contacts = where("email ilike ? OR first_name ilike ? OR last_name ilike ?", "%#{query}%", "%#{query}%", "%#{query}%")
    if contacts.empty?
      [{id: "<<<#{query}>>>", email: "Enter email, first name and last name with spaces: \"#{query}\""}]
    else
      contacts
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(email: $1.split[0], 
                                          first_name: $1.split[1], 
                                          last_name: $1.split[2]).id }
    tokens.split(',')
  end
  
  

end
