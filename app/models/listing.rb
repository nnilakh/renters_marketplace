class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  
  #Niki: Start - Whenever address changes geocode will validate the new address and regenerate latitude and longitude
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  #Niki: End - Whenever address changes geocode will validate the new address
  
     validates :listing_type, presence: true
     validates :room_type, presence: true
     validates :accomodates, presence: true
     validates :bedroom, presence: true
     validates :bathroom, presence: true
     validates :listing_name, presence: true, length: { maximum: 50 }
     validates :summary, presence: true, length: { maximum: 500 }
     validates :address, presence: true

end
