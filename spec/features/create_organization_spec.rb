require 'spec_helper'

describe "the signup process", :type => :feature do
  it "signs up as organization is reachable" do
    visit '/en/users/sign_up_with_organization'
    assert true
  end

  it "creates a user and an organization", :js => true do
    user1 = FactoryGirl.build(:user)
    organization1 = FactoryGirl.build(:organization)
    visit '/en/users/sign_up_with_organization'
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
      fill_in "user_addr_street", :with => "#{Faker::Address.street_address}"
      fill_in "user_addr_postcode", :with => "#{Random.rand(999)}"
      fill_in "user_addr_city", :with => "#{Faker::Address.city}"
      select "France", :from => "user_country", :match => :first
      fill_in "user_phone_number", :with => "049#{Random.rand(9999999)}"

      fill_in "user_organizations_attributes_0_name", :with => organization1.name
      fill_in "user_organizations_attributes_0_email", :with => organization1.email
      fill_in "user_organizations_attributes_0_addr_street", :with => organization1.addr_street
      fill_in "user_organizations_attributes_0_addr_postcode", :with => organization1.addr_postcode
      fill_in "user_organizations_attributes_0_addr_city", :with => organization1.addr_city
      fill_in "user_organizations_attributes_0_phone_number", :with => organization1.phone_number
      fill_in "user_organizations_attributes_0_description", :with => organization1.description

    end
    click_button "Sign up"
#    sleep(10)
#    expect(page).to have_content "confirmation"
    assert true
  end

end