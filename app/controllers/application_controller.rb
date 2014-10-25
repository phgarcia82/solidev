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

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :check_layout
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale, :load_menu
  include PathRewriterHelper
  include OwnershipHelper

  def authenticate_admin_user!
    redirect_to '/' and return if user_signed_in? && !current_user.is_system_admin?
    authenticate_user!
  end
  def current_admin_user
    return nil if user_signed_in? && !current_user.is_system_admin?
    current_user
  end

  protected

  def check_layout
    if params.has_key?(:no_layout)
      return false
    end
  end

  def configure_permitted_parameters
    #[:first_name, :last_name, :date_of_birth, :username, :addr_street, :addr_number, :addr_postcode, :addr_city, :phone_number, :avatar, :id_card,
    # organizations_attributes: [:name, :email, :addr_street, :addr_number, :addr_postcode, :addr_city, :phone_number, :site_url, :facebook_url, :description]].each do |d|
    #  devise_parameter_sanitizer.for(:sign_up) << d
    #end

    # new user model based on the new requirement
    [:fullname, :language_spoken, :username, :addr_street, :addr_number, :addr_postcode, :addr_city,
     organizations_attributes: [:name, :email, :addr_street, :addr_number, :addr_postcode, :addr_city, :phone_number, :site_url, :facebook_url, :description]].each do |d|
      devise_parameter_sanitizer.for(:sign_up) << d
    end

    [:fullname, :username, :addr_street, :addr_number, :addr_postcode, :addr_city].each do |d|
      devise_parameter_sanitizer.for(:account_update) << d
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def authenticate_user!(options={})
    redirect_to new_user_session_path, :alert => t("devise.failure.unauthenticated") unless user_signed_in?
  end

  def load_menu
    if user_signed_in?
      @menu_organizations = current_user.organization.to_a
      recognized_path = Rails.application.routes.recognize_path(request.env['PATH_INFO'])
      organization = false

      if recognized_path[:controller] == "organizations" && !recognized_path[:id].nil?
        organization =  current_user.organization.find_by_id(params[:id])
      elsif !recognized_path[:organization_id].nil?
        organization =  current_user.organization.find_by_id(params[:organization_id])
      end

      if organization
        @current_organization = organization
        if organization.has_admin? current_user
          @menu_people_in_need = organization.people_in_need

          if recognized_path[:controller] == "assistances" && !recognized_path[:id].nil?
            person_in_need =  User.find(params[:id])
          elsif !recognized_path[:people_in_need_id].nil?
            person_in_need =  User.find(params[:people_in_need_id])
          end

          if person_in_need
            @current_person_in_need = person_in_need
          end
        end

      end
    end
  end

end
