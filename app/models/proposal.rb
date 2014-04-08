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

class Proposal < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :user
  belongs_to :organization
  belongs_to :person_in_need ,:class_name => "User"
  has_many :comments, dependent: :destroy
  as_enum :status, :open => 0, :accepted => 1, :finished => 2, :closed => 3
  after_create :send_mail
  validates :description, length: {minimum: 5}

  def can_change_status
    status != :finished && status != :closed
  end

  def can_change_content
    status != :accepted && status != :finished && status != :closed
  end

  def can_owner_rate
    status == :finished && owner_rating.nil? && owner_msg.blank?
  end

  def can_proposer_rate
    status == :finished && proposer_rating.nil? && proposer_msg.blank?
  end

  def send_mail
    Notifications.new_proposal_email(self).deliver
  end

end
