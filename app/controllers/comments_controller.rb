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

class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @exchange = @proposal.exchange
    @comment = @proposal.comments.new(comment_params)
    set_ownership(@comment)
    if @comment.save
      redirect_to @exchange, notice: t(:comment_created)
    else
      render action: 'new'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @exchange = @comment.proposal.exchange
    if is_owner(@comment) && @comment.can_change_content
      @comment.update(comment_params)
    end
    redirect_to @exchange
  end

  def destroy
    @comment = Comment.find(params[:id])
    @exchange = @comment.proposal.exchange
    if is_owner(@comment)
      @comment.destroy
    end
    redirect_to @exchange, notice: t(:comment_deleted)
  end

  def author
    @comment = Comment.find(params[:comment_id])
    @author = owner(@comment)
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
  def comment_params
    params.require(:comment).permit(:content)
  end
end


