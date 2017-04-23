class ListingsController < ApplicationController
   before_action :set_listing, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @listings = current_user.listings
  end

  def show
    @photos = @listing.photos

  end

  def new
    @listing = current_user.listings.build
  end

  def create
    @listing = current_user.listings.build(listing_params)

    if @listing.save

      if params[:images] 
        params[:images].each do |image|
          @listing.photos.create(image: image)
        end
      end

      @photos = @listing.photos
      redirect_to edit_listing_path(@listing), notice: "Saved..."
    else
      render :new
    end
  end

  
  def edit
    if current_user.id == @listing.user.id
      @photos = @listing.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @listing.update(listing_params)

      if params[:images] 
        params[:images].each do |image|
          @listing.photos.create(image: image)
        end
      end

      redirect_to edit_listing_path(@listing), notice: "Updated..."
    else
      render :edit
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id]) 
    end

    def listing_params
      params.require(:listing).permit(:listing_type, :room_type, :accomodates, :bedroom, :bathroom, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active)
    end
end