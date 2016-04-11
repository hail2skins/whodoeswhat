require "test_helper"

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    login_as(login_user)
  end
  
  def teardown
    Capybara.use_default_driver
    logout
  end
  
  def login_user
    users(:login_user)
  end
  
  def load_business
    Business.find_by(name: "Load First Business")
  end
  
  test "create first article from kb article page" do
    visit "/"
    refute_links "KB - "
    #from load.rb to create business, group and membership
    load_first_group_business
    visit current_path
    check_links "KB - #{load_business.name}",
                "Contacts - #{load_business.name}"
    click_link "KB - #{load_business.name}"
    
    assert_equal business_articles_path(load_business), current_path
    assert_title "KB - #{load_business.name}"
    check_content "Please write an article capturing knowledge to begin."
    check_links "Click here to create an article.",
                "Return to main page"
    click_link "Click here to create an article."
    
    assert_equal new_business_article_path(load_business, Article.new), current_path
    assert_title "Create Knowledge"
    fill_in "Title", with: "First article testing"
    fill_in "Content", with: "I have to test 20 words or this will not work how I want so I am typing a lot here to make sure I am over 20 words and that's all I'm doing"

    click_button "Create article"
    
    assert_equal business_article_path(load_business, Article.find_by(name: "First article testing")), current_path
    
    click_link "Back to article index"
    
    assert_equal business_articles_path(load_business), current_path
    assert_css "table.table-kb-information"
    within(".table-kb-information") do
      check_content "Name",
                    "Content",
                    "Last touched",
                    Time.now.strftime("%m/%d/%Y"),
                    "First article testing"
    end
    
    
  end
  
  test "create second article from KB index" do
    load_first_group_business
    Article.create!(name: "Second article", 
                    content: "I have to test 20 words or this will not work how I want so I am typing a lot here to make sure I am over 20 words and that's all I'm doing",
                    business_id: load_business.id)
    visit "/"
    click_link "KB - #{load_business.name}"
    check_links "Create new article"
    click_link "Create new article"
    
    assert_equal new_business_article_path(load_business, Article.new), current_path
    fill_in "Title", with: "Second bitching article"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    click_button "Create article"
    
    click_link "Back to article index"
    
    check_content "Second bitching article",
                  "I want this to work.
                   I need this to work.
                   I will make it work.
                   I demand it to work.
                   Or..."
    
  end
  
  test "fail to create article without name and content" do
    load_first_group_business
    visit new_business_article_path(load_business, Article.new)
    
    click_button "Create article"
    check_content "can't be blank",
                  "your content must be at least 50 characters"
  end

  test "with an attachment" do
    load_first_group_business
    visit new_business_article_path(load_business)
    fill_in "Title", with: "Attachment test"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    attach_file "File", "test/files/speed.txt"
    click_button "Create article"
    
    within(".attachments") do
      check_content "speed.txt"
    end
  end
  
  test "persisting file uploads across form displays" do
    load_first_group_business
    visit new_business_article_path(load_business)
    attach_file "File", "test/files/speed.txt"
    click_button "Create article"
    
    fill_in "Title", with: "Persistence test"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    click_button "Create article"
    
    within(".attachments") do
      check_content "speed.txt"
    end
  end  
  
  test "with multiple attachments" do
    logout
    Capybara.current_driver = :poltergeist
    login_as(users(:article_user))
    visit new_business_article_path(businesses(:article_business))
    fill_in "Title", with: "Multiple attachments"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    attach_file "File", Rails.root.join("test/files/speed.txt")
    click_link "add attachment"
    within all("#attachment-fields").last do
      attach_file"File", Rails.root.join("test/files/spin.txt")
    end
    click_button "Create article"
    
    within(".attachments") do
      check_content "speed.txt",
                    "spin.txt"
    end
  end
  
  test "create article with single associated contact" do
    logout
    Capybara.current_driver = :poltergeist
    login_as(users(:article_user))
    visit new_business_article_path(businesses(:article_business))
    fill_in "Title", with: "Multiple contact test"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
   # page.find('input#article_contact_tokens', visible: false).set contact.id
    #Capybara.ignore_hidden_elements = false
    fill_token_input 'article_contact_tokens', with: "art@hamcois.com Art Mills"
    click_button "Create article"
    
    within(".contacts") do
      check_content "Art Mills",
                    "art@hamcois.com"
                    
    end
  end   
  
  test "create article with multiple associated contacts" do
    logout
    Capybara.current_driver = :poltergeist
    login_as(users(:article_user))
    visit new_business_article_path(businesses(:article_business))
    fill_in "Title", with: "Multiple contact test"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    fill_token_input 'article_contact_tokens', with: "art1@test.com Art Mills"
    fill_token_input 'article_contact_tokens', with: "jonathan1@test.com Jonathan Engstrom"
    click_button "Create article"
    
    within(".contacts") do
      check_content "Art Mills, art1@test.com",
                    "Jonathan Engstrom, jonathan1@test.com"
    end
    
  end

  test "create article with a single tag" do
    logout
    Capybara.current_driver = :poltergeist
    login_as(users(:article_user))
    visit new_business_article_path(businesses(:article_business))
    fill_in "Title", with: "Single contact test"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    fill_token_input 'article_tag_tokens', with: "Powershell_5"
    click_button "Create article"
    
    within(".tags") do
      check_content "Powershell_5"
                    
    end    
  end

end
