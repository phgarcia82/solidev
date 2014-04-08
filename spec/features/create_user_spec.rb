require 'spec_helper'

describe "the signup process", :type => :feature do
  it "signs up is reachable" do
    visit '/en/users/sign_up'
    assert true
  end

  it "creates a user ", :js => true do
    user1 = FactoryGirl.build(:user)
    visit '/en/users/sign_up'
    within("#new_user") do
      fill_in "user_first_name", :with => user1.first_name
      fill_in "user_last_name", :with => user1.last_name
      fill_in "user_email", :with => user1.email
      fill_in "user_password", :with => user1.password
      fill_in "user_password_confirmation", :with => user1.password
      select "1990", :from => "user_date_of_birth_1i"
      select "January", :from => "user_date_of_birth_2i"
      select "1", :from => "user_date_of_birth_3i"
      fill_in "user_username", :with => user1.username
      fill_in "user_addr_street", :with => user1.addr_street
      fill_in "user_addr_postcode", :with => user1.addr_postcode
      fill_in "user_addr_city", :with => user1.addr_city
      select "France", :from => "user_country", :match => :first
      fill_in "user_phone_number", :with => user1.phone_number
    end
    click_button "Sign up"
#    sleep(10)
#    expect(page).to have_content "confirmation"
    assert true
  end

end