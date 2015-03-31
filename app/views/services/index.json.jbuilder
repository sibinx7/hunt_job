json.array!(@services) do |service|
  json.extract! service, :id, :title, :description, :creator, :service_image, :service_link
  json.url service_url(service, format: :json)
end
