class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  
  #Niki: Start - Full name property must be present + max length should be 50
  validates :fullname, presence: true, length: { maximum: 50 }
  #Niki: End - Full name property must be present + max length should be 50      
  
  has_many :listings
  
  def self.from_omniauth(auth)
   
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.fullname = auth.info.name
  			user.provider = auth.provider
  			user.uid = auth.uid
  			user.email = auth.info.email
  			user.image = auth.info.image
  			user.password = Devise.friendly_token[0,20]
  		end
  end
end
