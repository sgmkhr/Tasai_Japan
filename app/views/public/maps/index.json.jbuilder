json.data do
  json.items do
    json.array!(@posts) do |post|
      json.id post.id
      json.user do
        json.name post.user.public_name
        json.image url_for(post.user.profile_image)
      end
      json.post_image url_for(post.post_image)
      json.title post.title
      json.caption post.caption
      json.address post.address
      json.latitude post.latitude
      json.longitude post.longitude
    end  
  end
end