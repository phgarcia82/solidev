require 'date'

class ExchangesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    #Exchange.search(:include => [:comments])
    if params.has_key?(:search)
      search = params[:search]

      query_string = search[:text]

      start_date = nil
      end_date = nil

      if !search[:start].blank?
        start_date = DateTime.parse(search[:start]).strftime("%Y-%m-%dT%H:%M:%SZ")
      end

      if !search[:end].blank?
        end_date = DateTime.parse(search[:end]).strftime("%Y-%m-%dT%H:%M:%SZ")
      end

      # location and distance
      location = params[:location]
      distance = params[:distance]
      quantity = search[:quantity]
      is_offer = search[:is_offer]
      is_demand = search[:is_demand]

      # If query key equals to the search place holder (meaning no keywords is placed), return ALL as default
      if query_string.blank?
        @all = 0
        @exchanges = Sunspot.search(Exchange) do
          # geospatial
          with(:location).in_radius(location.split(',')[0], location.split(',')[1], distance)
          # quantity
          if !quantity.blank?
            with :quantity, quantity
          end
          # offer
          if !is_offer.blank?
            with :is_offer, is_offer
          end
          # demand
          if !is_demand.blank?
            with :is_demand, is_demand
          end

          # date time
          if !search[:start].blank?
            with(:start).greater_than(search[:start])
          end

          if !search[:end].blank?
            with(:end).less_than(search[:end])
          end

          # facet :category_id
          # pagination
          paginate(:page => params[:page] || 1, :per_page => 13)
        end
      else
        @all = 0
        # start searching
        @exchanges = Sunspot.search(Exchange) do
          # keyword search
          keywords query_string, :fields => [:title, :description]
          # geospatial
          with(:location).in_radius(location.split(',')[0], location.split(',')[1], distance)
          # quantity
          if !quantity.blank?
            with :quantity, quantity
          end
          # offer
          if !is_offer.blank?
            with :is_offer, is_offer
          end
          # demand
          if !is_demand.blank?
            with :is_demand, is_demand
          end

          # date time
          if !search[:start].blank?
            facet :start
          end

          if !search[:end].blank?
            facet :end
          end

          # facet :category_id
          # pagination
          paginate(:page => params[:page] || 1, :per_page => 13)
        end
      end

      #if params[:nolayout]
      render "_results", :layout => false
      #end
    else
      @exchanges = Exchange.all.paginate(:page => params[:page], :per_page => 13)
      @no_controller = true
    end
  end

  def show
    @exchange = Exchange.find(params[:id])
    @proposals = @exchange.proposals.select { |p| (p.is_visible || is_owner(p)) }
    @new_proposal = @exchange.proposals.new
  end

  def new
    @exchange = Exchange.new
  end

  def edit
    @exchange = Exchange.find(params[:id])
  end

  def create
    @exchange = Exchange.new(exchange_params)
    @exchange.user = @current_user
    @exchange.organization = @current_organization
    @exchange.person_in_need = @current_person_in_need
    @exchange.created_date = Time.now
    @exchange.created_user = @current_user.id
    if !(@exchange.start.nil? ) && !(@exchange.end.nil? ) && @exchange.start < Time.now && @exchange.end > Time.now
      @exchange.status = 0
    else
      @exchange.status = 1
    end
    if @exchange.save
      redirect_to @exchange, notice: t(:exchange_created)
    else
      render action: 'new'
    end
  end

  def update

    @exchange = Exchange.find(params[:id])
    if @exchange.user == @current_user &&  @exchange.update(exchange_params)
      redirect_to @exchange, notice: t(:exchange_updated)
    elsif @exchange.user == @current_user
      render action: 'edit'
    else
      redirect_to @exchange, notice: t(:not_the_owner)
    end
  end

  def destroy
    @exchange = Exchange.find(params[:id])
    @exchange.destroy
    redirect_to exchanges_url, notice: t(:exchange_deleted)
  end

  def author
    @exchange = Exchange.find(params[:exchange_id])
    @author = owner(@exchange)
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
  def exchange_params
    params.require(:exchange).permit(:title, :quantity, :is_offer, :is_demand, :start, :end, :description, :picture, :location, :page, :distance, :latitude, :longitude, :category_id)
  end
end
