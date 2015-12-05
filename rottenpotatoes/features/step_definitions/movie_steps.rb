require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# HW 4

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    new_movie = Movie.create!(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
   #path="/html/body/div/table/tbody/tr[1]/td[1]">
   first_row = page.find('td', :text => e1, :match => :prefer_exact)
   second_row = page.find('td', :text => e2, :match => :prefer_exact)
   
   fail "Error Message" unless first_row.path < second_row.path
end

Then /the director of "(.*)" should be "(.*)"/ do |m, director|
  if page.respond_to? :should
    page.should have_content(m)
    page.should have_content(director)
  else
    assert page.has_content?(director)
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: "(.*)"/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # fail "Unimplemented"
  rating_list.split(',').each do |x|
    checkbox_id = "ratings_#{x.strip}"
    if uncheck
      uncheck(checkbox_id)
    else
      check(checkbox_id)
    end
  end
end


Then /I should see all the movies/ do
  
  page.all('table#movies tbody tr').count.should == 10
  
end
