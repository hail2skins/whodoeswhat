module TokenInputHelper
  def fill_token_input(locator, options)
    raise "Must pass a hash containing 'with'" unless options.is_a?(Hash) && options.has_key?(:with)
    page.execute_script %Q{$('#token-input-#{locator}').val('#{options[:with]}').keydown()}
    sleep(5)
    find(:xpath, "//div[@class='token-input-dropdown-facebook']/ul/li[contains(string(),'#{options[:with]}')]").click
  end
  
  def clear_token_input(id, options={})
    page.driver.execute_script("$('##{id}').tokenInput('remove', #{options.to_json})")
    sleep(0.1)
  end
end