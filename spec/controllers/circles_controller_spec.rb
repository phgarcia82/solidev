require 'rails_helper'

RSpec.describe CirclesController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      expect(response).to be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      expect(response).to be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      expect(response).to be_success
    end
  end

  describe "GET 'delete'" do
    it "returns http success" do
      get 'delete'
      expect(response).to be_success
    end
  end

  describe "GET 'add_user'" do
    it "returns http success" do
      get 'add_user'
      expect(response).to be_success
    end
  end

  describe "GET 'remove_user'" do
    it "returns http success" do
      get 'remove_user'
      expect(response).to be_success
    end
  end

end
