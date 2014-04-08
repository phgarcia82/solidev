require 'spec_helper'

describe UsersController do
  describe "Get #index" do #, {:q => nil} do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    # =========================== utils?
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
    # =========================== utils?


    it "all users putted in @users" do
      #get 'index'
      #pouet = User.create!(username: "pouet", first_name: "pouet", last_name: "pouet", email: "pouet@b.c", password: "12345678", password_confirmation: "12345678")
      array = User.all

      #lindeman = FactoryGirl.create(:user)
      #chelimsky = FactoryGirl.create(:user)

      get :index
      expect(assigns(:users)).to match_array(array)
    end
  end
end