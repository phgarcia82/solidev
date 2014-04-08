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

class AssistancesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @person_in_need = User.find(params[:id])
  end

  def index

  end

  def create
    @organization = Organization.find(params[:organization_id])

    if @organization.has_member? current_user
      @assistance = @organization.assistances.new(params[:assistance].permit!())
      generated_password = Devise.friendly_token.first(8)
      @assistance.user.password = generated_password
      @assistance.save
    end

    redirect_to @organization
  end

  def edit
    @organization = Organization.find(params[:organization_id])

    if @organization.has_member? current_user
      @assistance = @organization.assistances.where(:user_id => params[:id]).first
      render :layout => false
    end
  end

  def update
    @organization = Organization.find(params[:organization_id])

    if @organization.has_member? current_user
      @assistance = @organization.assistances.where(:user_id => params[:id]).first
      @assistance.update(params[:assistance].permit!())
    end

    redirect_to @organization
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    if @organization.has_admin? current_user
      @assistance = @organization.assistances.where(:user_id => params[:id]).first
      @assistance.destroy()
      redirect_to @organization
    end

  end
end
