require "test_helper"

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    login_as(login_user)
  end
  
  def teardown
    click_link "Sign out"
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
    check_links "KB - #{load_business.name}"
    click_link "KB - #{load_business.name}"
    
    assert_equal business_articles_path(load_business), current_path
    assert_title "KB - #{load_business.name}"
    check_content "Please write an article capturing knowledge to begin."
    check_links "Click here to create an article.",
                "Return to main page"
    click_link "Click here to create an article."
    
    assert_equal new_business_article_path(load_business, Article.new), current_path
    assert_title "Create Knowledge"
    fill_in "Name", with: "First article testing"
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
    fill_in "Name", with: "Second bitching article"
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
    fill_in "Name", with: "Attachment test"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    attach_file "File #1", "test/files/speed.txt"
    click_button "Create article"
    
    within(".attachments") do
      check_content "speed.txt"
    end
  end
  
  test "persisting file uploads across form displays" do
    load_first_group_business
    visit new_business_article_path(load_business)
    attach_file "File #1", "test/files/speed.txt"
    click_button "Create article"
    
    fill_in "Name", with: "Persistence test"
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
    #Capybara.javascript_driver = :webkit
    load_first_group_business
    visit new_business_article_path(load_business)
    fill_in "Name", with: "Multiple attachments"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    attach_file "File #1", Rails.root.join("test/files/speed.txt")
    click_link "Add another file"
    attach_file "File #2", Rails.root.join("test/files/spin.txt")
    click_button "Create article"
    
    within(".attachments") do
      check_content "speed.txt",
                    "spin.txt"
    end
    #Capybara.use_default_driver
  end
  
  
end
