""" Solidare-IT! is an initiative that tries to enhance the solidarity and
the exchange between citizens of all layers of society.
Copyright (C) 2013 Bourgeois Mathieu, Bui Duc Viet, Bui Tuan-Anh,
Couniot Antoine, Guido Marco, Ha Quang Minh, Joris Van Hecke, Xu Xiao.

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

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /users
  # GET /users.json
  def index
    if params[:q].nil?
      @users = User.all
    else
      @users = User.where("users.encrypted_password IS NOT NULL AND users.encrypted_password != ''").where("email like?", "#{params[:q]}%").limit(10)
      render json: @users, :only => [ :id, :email ]
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
     @author = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }

      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }

      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

    @save = @user
       if @user.destroy
          Exchange.where("user_id = ?",@save.id).each do |exchange|
             exchange.destroy
      end
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]

    end

end
