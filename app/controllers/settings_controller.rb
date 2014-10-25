class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def personal
    if !current_user.is_organisation_member
      @user = User.new
    end
  end

  def organisation
    if current_user.is_organisation_member

    end
  end
end
