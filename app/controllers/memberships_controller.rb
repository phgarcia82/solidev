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

class MembershipsController < ApplicationController
  def create
    @organization = Organization.find(params[:organization_id])

    if @organization.has_member? current_user
      @membership = @organization.memberships.new(params[:membership].permit(:user_email))
      @membership.validated = true
      @membership.save
    else # NOT A MEMBER
      @membership = @organization.memberships.new(:user => current_user, :validated => false)
      @membership.save
    end

    redirect_to @organization
  end


  def edit
    @organization = Organization.find(params[:organization_id])
    if @organization.has_member? current_user
      @membership = @organization.memberships.find(params[:id])
    end
  end

  def update
    @organization = Organization.find(params[:organization_id])
    if @organization.has_member? current_user
      @membership = Membership.find(params[:id], :readonly => false)
      @membership.update(params[:membership].permit!)
    end
    redirect_to @organization
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    if @organization.has_admin? current_user
      @membership = Membership.find(params[:id], :readonly => false)
      @membership.destroy
    end
    redirect_to @organization
  end
end
