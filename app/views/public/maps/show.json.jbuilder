json.data do
  json.item do
    json.title @post.title
    json.caption @post.caption
    json.address @post.address
    json.latitude @post.latitude
    json.longitude @post.longitude
  end
end
