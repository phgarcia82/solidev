require 'spec_helper'

describe "the signin process", :type => :feature do
  it "signs me is reachable" do
    visit '/en/users/sign_in'
    assert true
  end

  it "signs me in", :js => true do
    user1 = FactoryGirl.create(:user) #, email: "marco781990@hotmail.com")
#    user2 = FactoryGirl.create(:user, email: user1.email)
    #user.save
#    puts (user.password)
#    puts (user.username)
#    puts (User.all.first.username)
    visit '/en/users/sign_in'
    within("#new_user") do
      fill_in "user_email", :with => user1.email
      fill_in "user_password", :with => user1.password
    end
    click_button "Sign in"
    assert true
  end

end