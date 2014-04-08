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

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  delegate :email, :to => :user, :prefix => true, :allow_nil => true
  validates :user_id, :uniqueness => {:scope => :organization_id}
  validates_presence_of :user, :organization
  before_destroy :is_not_last_admin?

  def user_email=(user_email)
    user = User.find_by_email(user_email)
    if user.nil?
      self.user = User.invite!(:email => user_email)
    else
      self.user = user
    end
  end

  def is_not_last_admin?
    admin_count = organization.memberships.where(:admin => true).count
    return !(admin_count <= 1 && organization.has_admin?(user))
  end

  def admin=(admin)
    admin_count = organization.memberships.where(:admin => true).count
    if (admin == false || admin == "0" || admin == 0) && admin_count <= 1 && self.admin
      errors.add(:admin, I18n.t(:can_not_remove_last_admin))
    else
      self[:admin] = admin
    end

  end

end
