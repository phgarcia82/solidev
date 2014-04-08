require 'spec_helper'

describe User do
  describe "creation :" do #, {:q => nil} do
    it "two users cannot have the same email" do
      #get 'index'
      #pouet = User.create!(username: "pouet", first_name: "pouet", last_name: "pouet", email: "pouet@b.c", password: "12345678", password_confirmation: "12345678")
      user1 = FactoryGirl.create(:user)
#      puts(user1.first_name)
      begin
        user2 = FactoryGirl.create(:user, user1.email)
#        puts(user2.first_name)
        assert false, "possible to create two users with same email"
      rescue => e
#        puts(e.message)
        assert true
        #expect(User.all).to eq([lindeman, chelimsky])
      #response.should respond_to([lindeman, chelimsky])
      #response.should eq([lindeman, chelimsky])
      #expect(User.all).to eq([lindeman, lindeman2])
      end
    end

    it "two users cannot have the same username" do
      user1 = FactoryGirl.create(:user)
      begin
        user2 = FactoryGirl.create(:user, username: user1.username)
        assert false, "possible to create two users with same username"
      rescue => e
        assert true
      end
    end

    it "password minimum size: 8 characters" do
      user1 = FactoryGirl.create(:user)
      begin
        user2 = FactoryGirl.create(:user, password: "1234567", password_confirmation: "1234567")
        assert false, "possible to create a user with a password too short"
      rescue => e
        assert true
      end
    end

    it "email has to be valid" do
      user1 = FactoryGirl.create(:user)
      begin
        user2 = FactoryGirl.create(:user, email: "hello")
        assert false, "possible to create a user with invalid email"
      rescue => e
        assert true
      end
    end

    it "password confirmation has to be the same of original password" do
      user1 = FactoryGirl.create(:user)
      begin
        user2 = FactoryGirl.create(:user, password: "12345678", password_confirmation: "12345679")
        assert false, "possible to create a user with password not well confirmed"
      rescue => e
        assert true
      end
    end

  end
end