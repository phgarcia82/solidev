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

class ProposalsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_user!, :except => [:index, :show]

  def create
    @exchange = Exchange.find(params[:exchange_id])
    @proposal = @exchange.proposals.new(proposal_params)
    set_ownership(@proposal)
    if @proposal.save
      redirect_to @exchange, notice: t(:proposal_created)
    else
      render action: 'new'
    end
  end

  def update
    @proposal = Proposal.find(params[:id])
    @exchange = @proposal.exchange
    if is_owner(@exchange)
      if @proposal.can_change_status
        @proposal.update(proposal_params_for_exchange_owner)
      end
      if @proposal.can_owner_rate
        @proposal.update(params[:proposal].permit(:owner_rating))
      end
    end
    if is_owner(@proposal)
      if @proposal.can_change_content
        @proposal.update(proposal_params)
      end
      if @proposal.can_proposer_rate
        @proposal.update(params[:proposal].permit(:proposer_rating))
      end
    end
    redirect_to @exchange
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    @exchange = @proposal.exchange
    if is_owner(@proposal) || is_owner(@exchange)
      @proposal.destroy
    end
    redirect_to @exchange, notice: t(:proposal_deleted)
  end

  def author
    @proposal = Proposal.find(params[:proposal_id])
    @author = owner(@proposal)
    if @author.instance_of?(User)
      @user = @author
      render "users/show"
    elsif @author.instance_of?(Organization)
      @organization = @author
      @memberships = @organization.memberships.all
      @new_membership = @organization.memberships.new
      @assistances = @organization.assistances.all
      @new_assistance = @organization.assistances.build
      @new_assistance.user = User.new
      render "organizations/show"
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def proposal_params
    params.require(:proposal).permit(:description, :is_visible)
  end

  def proposal_params_for_exchange_owner
    params.require(:proposal).permit(:status)
  end
end

