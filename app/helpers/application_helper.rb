module ApplicationHelper
    #Niki: Start - Adding an avatar for user
    def avatar_url(user)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        if user.image
            user.image
        else
            "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
        end
    end  
    #Niki: End - Adding an avatar for user
end
