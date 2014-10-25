class CirclesController < ApplicationController
  before_action :set_circles, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    if current_user.is_organisation_member
      @circles = Circles.all.where(:user_id => current_user.organization.id)
    else
      @circles = Circles.all.where(:user_id => current_user.id)
    end
  end

  def show
    @circle = Circles.find(params[:id])
    @members = CirclesMembers.where("circle_id = ?", @circle.id)
  end

  def new
    @circles = Circles.new
  end

  def create
    @circles = Circles.new(circles_params)
    @circles.organisation_id = current_user.organisation_id
    @circles.user_id = current_user.id

    if @circles.save
      redirect_to circles_path, notice: 'Circles created!'
    else
      render action: 'new'
    end
  end

  def edit
    @circles = Circles.find(params[:id])
  end

  def update
    if @circles.update(circles_params)
      redirect_to @circles, :notice => 'Updated successfully!'
    else
      render action: 'edit'
    end
  end

  def destroy
    @circles = Circles.find(params[:id])
    @save = @circles
    @members = CirclesMembers.where("circle_id = ?", @save.id)
    if @circles.destroy
      @members.each do |item|
        item.destroy
      end

      respond_to do |format|
        format.html { redirect_to circles_path, notice: "Deleted successfully!" }
      end
    else
      respond_to do |format|
        format.html { redirect_to circles_path }
      end
    end
  end

  def add_user
    @user = User.new
  end

  def add_user_process
    @user = params[:user]
    @username = @user[:username]
    @circle_id = params[:circle_id]
    @user_object = User.where("username = ?", @username).take!

    # if the user exists
    if !@user_object.nil?
      # add to circle
      @circle_members = CirclesMembers.new(:user_id => @user_object.id, :circle_id => @circle_id)
      if @circle_members.save
        respond_to do |format|
          format.html { redirect_to circle_path(@circle_id), notice: "New user added!"  }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to circle_path(@circle_id), notice: "New user does not exist!"  }
      end
    end
  end

  def remove_user
    @entity = CirclesMembers.find(params[:id])
    if @entity.destroy
      redirect_to circle_path(:id => params[:circle_id])
    end
  end

  private
  def set_circles
    @circles = Circles.find(params[:id])
  end

  def circles_params
    params.require(:circles).permit(:name)
  end
end
