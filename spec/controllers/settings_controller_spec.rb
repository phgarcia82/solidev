require 'rails_helper'

RSpec.describe SettingsController, :type => :controller do

  describe "GET 'personal'" do
    it "returns http success" do
      get 'personal'
      expect(response).to be_success
    end
  end

  describe "GET 'organisation'" do
    it "returns http success" do
      get 'organisation'
      expect(response).to be_success
    end
  end

end
