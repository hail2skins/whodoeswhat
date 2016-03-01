  def check_content(*args)
    args.each do |arg|
      assert page.has_content?(arg), "Content -- #{arg} not available."
    end
  end
  
  def check_links(*args)
    args.each do |arg|
      assert page.has_link?(arg), "Link -- #{arg} not available."
    end
  end
  
  def refute_content(*args)
    args.each do |arg|
      refute page.has_content?(arg), "Refute -- #{arg} is available, but shouldn't be."
    end
  end
  
  def refute_links(*args)
    args.each do |arg|
      refute page.has_link?(arg), "Refute -- #{arg} link is available, but shouldn't be."
    end
  end  
  
  def check_something(something, *args)
    args.each do |arg|
      if something == "link"
        assert page.has_link?(arg), "#{something}.capitalize -- #{arg} not available."
      else
        assert page.has_content?(arg), "#{something}.capitalize -- #{arg} not available."
      end
    end
  end
  
  def logout
    click_link "Sign out"
  end