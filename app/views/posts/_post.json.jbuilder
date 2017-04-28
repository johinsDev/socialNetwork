json.post do
  json.id post.id
  json.body post.body
  json.created_at post.created_at
  json.updated_at post.updated_at
  json.user post.user
  json.url post_url(post, format: :json)
end
