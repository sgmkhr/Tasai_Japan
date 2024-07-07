json.data do
  json.items do
    json.array!(@posts) do |post|
      json.id post.id
      json.title post.title
      json.caption post.caption
      json.address post.address
      json.latitude post.latitude
      json.longitude post.longitude
    end
  end
end
