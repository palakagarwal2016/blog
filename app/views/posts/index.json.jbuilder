json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :permalink
  json.url post_url(post, format: :json)
end
