module ApplicationHelper
    #Niki: Start - Helper method to get gravatar based on user email/fb login
    def avatar_url(user)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        if user.image
            user.image
        else
            "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
        end
    end  
    #Niki: End - Helper method to get gravatar based on user email/fb login
end
