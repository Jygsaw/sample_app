module CustomMatchers

  RSpec::Matchers.define :have_error_explanation do |message|
    match do |page|
      page.should have_selector('div#error_explanation', text: message)
    end
  end

  RSpec::Matchers.define :have_error_message do |message|
    match do |page|
      page.should have_selector('div.alert.alert-error', text: message)
    end
  end

  RSpec::Matchers.define :have_success_message do |message|
    match do |page|
      page.should have_selector('div.alert.alert-success', text: message)
    end
  end

  RSpec::Matchers.define :have_title do |message|
    match do |page|
      page.should have_selector('title', text: full_title(message))
    end
  end

  RSpec::Matchers.define :have_heading do |message|
    match do |page|
      page.should have_selector('h1', text: message)
    end
  end

end
