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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable, :trackable, :validatable, :invitable
  has_many :memberships, :conditions => {:validated => true}
  has_many :assistances
  has_many :organizations, :through => :memberships
  has_attached_file :id_card, :styles => { :medium => "500x500>", :thumb => "100x100>" }, :default_url => "/missing_id_card_:style.png"
  has_attached_file :avatar, :styles => { :medium => "500x500>", :thumb => "100x100>", :icon => "34x34", :navbar => "25x25" }, :default_url => "missing_avatar_:style.png"
  accepts_nested_attributes_for :organizations
  #validates_date :date_of_birth, :before => Time.now
  validates_presence_of :username, :addr_city, :fullname
  before_create :set_admin_if_first


  def full_name
    fullname
  end

  def displayed_name
    if !username.blank?
      username
    else
      fullname
    end
  end

  def set_admin_if_first
    if User.all.count == 0
      self.is_system_admin = true
    end
  end

  def own_proposals
    Proposal.where("(user_id = ? AND organization_id IS NULL AND person_in_need_id IS NULL) OR (person_in_need_id = ?)",self.id, self.id)
  end

  def own_exchanges
    Exchange.where("(user_id = ? AND organization_id IS NULL AND person_in_need_id IS NULL) OR (person_in_need_id = ?)", self.id, self.id)
  end

  def rating
    @proposal_rating = Proposal.where("(user_id = ? AND organization_id IS NULL AND person_in_need_id IS NULL AND owner_rating IS NOT NULL) OR (person_in_need_id = ? AND owner_rating IS NOT NULL)  ",self.id, self.id)
    @sum_proposal = 0
    @count = 0
    @proposal_rating.each do |proposal_rating|
      @sum_proposal = proposal_rating.owner_rating + @sum_proposal
      @count = @count +1
    end
    if @count > 0
      @sum_proposal = @sum_proposal/@count
    end

    @count = 0
    @sum_exchange = 0
    @exchange_rating = Proposal.where("(user_id = ? AND organization_id IS NULL AND person_in_need_id IS NULL AND proposer_rating IS NOT NULL) OR (person_in_need_id = ? AND proposer_rating IS NOT NULL)", self.id, self.id)
    @exchange_rating.each do |exchange_rating|
      @sum_exchange = exchange_rating.proposer_rating + @sum_exchange
      @count = @count +1
    end
    if @count > 0
      @sum_exchange = @sum_exchange/@count
    end

    (@sum_proposal)+(@sum_exchange)

  end
end
