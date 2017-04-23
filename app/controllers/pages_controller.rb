class PagesController < ApplicationController
  def home
    @listings = Listing.limit(3)
  end
  
def search
  	
  	if params[:search].present? && params[:search].strip != ""
  		session[:loc_search] = params[:search]
  	end

  	if session[:loc_search] && session[:loc_search] != ""
  		@listings_address = Listing.where(active: true).near(session[:loc_search], 5, order: 'distance')
  	end

  	@search = @listings_address.ransack(params[:q])
  	@listings = @search.result

  	@arrlistings = @listings.to_a

  	if (params[:start_date] && params[:end_date] && !params[:start_date].empty? & !params[:end_date].empty?)

  		start_date = Date.parse(params[:start_date])
  		end_date = Date.parse(params[:end_date])

  		@listings.each do |listing|

  			not_available = listing.reservations.where(
  					"(? <= start_date AND start_date <= ?)
  					OR (? <= end_date AND end_date <= ?) 
  					OR (start_date < ? AND ? < end_date)",
  					start_date, end_date,
  					start_date, end_date,
  					start_date, end_date
  				).limit(1)

  			if not_available.length > 0
  				@arrlistings.delete(listing)	
  			end	

  		end

  	end
end
end

