json.array!(@projects) do |project|
  json.extract! project, :id, :title, :description, :creator, :skills, :min_budget, :max_budget, :duration, :developer
  json.url project_url(project, format: :json)
end
