module UsersHelper
    def profile_image(user)
        if user.profile_image.attached? 
          image_tag user.profile_image 
        else 
          image_tag "profile.png" 
        end
      end
end
