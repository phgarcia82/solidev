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

class OrganizationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]


  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
    @memberships = @organization.memberships.all
    @new_membership = @organization.memberships.new
    @assistances = @organization.assistances.all
    @new_assistance = @organization.assistances.build
    @new_assistance.user = User.new
  end

  def new
    @organization = current_user.organizations.new
  end

  def edit
    @organization = Organization.find(params[:id])
    if !@organization.has_admin?(current_user)
      redirect_to @organization, alert: t(:organization_error)
    end
  end

  def create
    @organization = current_user.organizations.new(organization_params)
    if current_user.save
      redirect_to @organization, notice: t(:organization_created)
    else
      render action: 'new'
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if !@organization.has_admin?(current_user)
      redirect_to @organization, alert: t(:organization_error)
    else
      if @organization.update(organization_params)
          redirect_to @organization, notice: t(:organization_updated)
      elsif !@organization.has_admin?
        render action: 'edit'
      else
        redirect_to @organization, alert: t(:organization_error_last_admin)
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    if !@organization.has_admin?(current_user)
      redirect_to @organization, alert: t(:organization_error)
    else
      @organization.destroy
      redirect_to organizations_url
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :email, :addr_street, :addr_number, :addr_postcode, :addr_city, :phone_number, :org_number, :site_url, :facebook_url, :description, :use_own_email)
    end

end
