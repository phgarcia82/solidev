""" Solidare-IT! is an initiative that tries to enhance the solidarity and
the exchange between citizens of all layers of society.
Copyright (C) 2013 Bourgeois Mathieu, Bui Duc Viet, Bui Tuan-Anh,
Couniot Antoine, Guido Marco Ha Quang Minh, Joris Van Hecke, Xu Xiao.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>."""

class RegistrationsController < Devise::RegistrationsController
  # override to add recaptcha
  def create
    if verify_recaptcha
      # here we process two cases: organisation and personal account
      if params[:user][:organization_attributes].blank?
        # personal account, nothing special here
        super
      else
        # this is an organisation. then first we need to assign addr_city to user to come over the constraint
        params.permit!
        @organisation = Organization.new(organisation_params)
        if @organisation.save
          # get id, get city
          @id = @organisation.id
          @city = @organisation.addr_city
          @sign_up_params = sign_up_params
          @sign_up_params[:addr_city] = @city
          @sign_up_params[:organisation_id] = @id
          #re-assign
          # devise process continues - not using the super method here
          build_resource(@sign_up_params)
          if resource.save
            yield resource if block_given?
            if resource.active_for_authentication?
              set_flash_message :notice, :signed_up if is_flashing_format?
              sign_up(resource_name, resource)
              respond_with resource, location: after_sign_up_path_for(resource)
            else
              set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
              expire_data_after_sign_in!
              respond_with resource, location: after_inactive_sign_up_path_for(resource)
            end
          else
            clean_up_passwords resource
            respond_with resource
          end


        end
      end
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
      flash.delete :recaptcha_error

      if params[:user][:organization_attributes].blank?
        # personal account, nothing special here
        render :new
      else
        # this is an organisation. then first we need to assign addr_city to user to come over the constraint
        render :new_with_organization
      end

    end
  end

  def new
    build_resource({})
    respond_with self.resource
  end

  def create_account

  end

  def new_with_user
    new()
  end

  def new_with_organization
    @organisation = Organization.new
    @user = User.new

  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # if password changes
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user]
  end

  def organisation_params
    params[:user][:organization_attributes]
  end
end
