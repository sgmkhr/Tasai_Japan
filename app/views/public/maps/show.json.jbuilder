json.data do
  json.item do
    json.title @post.title
    json.latitude @post.latitude
    json.longitude @post.longitude
  end
end