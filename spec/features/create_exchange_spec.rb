require 'spec_helper'

describe "the exchange creation process", :type => :feature do

  it "creates an exchange is not reachable if not loggin", :js => false do
    visit '/en/exchanges/new'
    expect(page).to have_content "sign up"
  end

  it "creates an offer ", :js => true do
    user1 = FactoryGirl.create(:user)
    visit '/en/users/sign_in'
    within("#new_user") do
      fill_in "user_email", :with => user1.email
      fill_in "user_password", :with => user1.password
    end
    click_button "Sign in"
#    expect(page).to have_content "success"
    visit '/en/exchanges/new'
    within("#new_exchange") do
      fill_in "exchange_title", :with => "#{Faker::Lorem.sentence(3)}"
      fill_in "exchange_quantity", :with => "#{"#{Random.rand(4) + 1}"}"
      check("exchange_is_offer")
      fill_in 'exchange_start', :with => "#{Date.today}"
      fill_in 'exchange_end', :with => "#{Date.today + 1}"
      fill_in 'description', :with => "#{Faker::Lorem.sentence(10)}"
    end

    click_button "Create"
    expect(page).to have_content "success"
  end

  it "creates a demand ", :js => true do
    user1 = FactoryGirl.create(:user)
    visit '/en/users/sign_in'
    within("#new_user") do
      fill_in "user_email", :with => user1.email
      fill_in "user_password", :with => user1.password
    end
    click_button "Sign in"
#    expect(page).to have_content "success"
    visit '/en/exchanges/new'
    within("#new_exchange") do
      fill_in "exchange_title", :with => "#{Faker::Lorem.sentence(3)}"
      fill_in "exchange_quantity", :with => "#{"#{Random.rand(4) + 1}"}"
      check("exchange_is_demand")
      fill_in 'exchange_start', :with => "#{Date.today}"
      fill_in 'exchange_end', :with => "#{Date.today + 1}"
      fill_in 'description', :with => "#{Faker::Lorem.sentence(10)}"
    end

    click_button "Create"
    expect(page).to have_content "success"
  end

end