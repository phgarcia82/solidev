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

class Organization < ActiveRecord::Base
  has_many :memberships, -> { where(validated: true).joins(:user).where("users.encrypted_password IS NOT NULL AND users.encrypted_password != ''") }
  has_many :members, :through => :memberships, :source => :user
  has_many :assistances
  has_many :people_in_need, :through => :assistances, :source => :user
  has_attached_file :logo, :styles => { :medium => "500x500>", :thumb => "100x100>", :icon => "34x34", :navbar => "25x25" }, :default_url => "missing_logo_:style.png"
  after_commit :set_first_user_as_founder, :on => :create
  validates_presence_of :organisation_name, :addr_city
  validates :description, length: {minimum: 10}

  def set_first_user_as_founder
    # Warning: cannot use organization.memberships, given the conditions
    first = Membership.where(:organization => self).first
    first.validated = true
    first.admin = true
    first.founder = true
    first.save
  end

  def has_admin?(user)
    membership = user.memberships.where(:organization => self).first
    return membership != nil && membership.validated && membership.admin
  end

  def has_member?(user)
    membership = user.memberships.where(:organization => self).first
    return membership != nil && membership.validated
  end

  def waiting_for_validation?(user)
    membership = Membership.where(:organization => self, :user => user).first
    return membership != nil && !membership.validated
  end
end
