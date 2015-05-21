json.array!(@user_ratings) do |user_rating|
  json.extract! user_rating, :id, :user_id, :description, :rating, :rated_by, :project_id
  json.url user_rating_url(user_rating, format: :json)
end
