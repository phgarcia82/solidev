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

class Exchange < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  belongs_to :organization
  belongs_to :person_in_need ,:class_name => "User"
  has_many :proposals, dependent: :destroy
  has_attached_file :picture, :styles => { :medium => "500x500>", :thumb => "100x100>"} , :default_url => "missing_exchange_:style.png"
  as_enum :status, :open => 0, :closed => 1
  validates :title, :description, :start, :end, presence: true
  validates :description, length: {minimum: 10}
  validates :quantity, numericality: { only_integer: true }
  validates_date :start, :before => lambda{|m| m.end}
  validates_date :end, :after => lambda{|m| m.start}
  validate :type_defined?

  # Sunspot index objects
  searchable do
    text :title, :default_boost => 2, :as => :code_textp
    text :description, :as => :code_textp
    integer :category_id, :multiple => true, :references => Category
    boolean :is_offer
    boolean :is_demand
    integer :quantity

    # geospatial
    latlon(:location) { Sunspot::Util::Coordinates.new(self.latitude, self.longitude) }

    # facet
    time :start
    time :end
    time :created_date
  end


  def type_defined?
    if !is_demand & !is_offer
       errors.add(:is_demand,:no_type_error)
       errors.add(:is_offer)
    end
  end

  def can_propose
    return status != :closed
  end
end





