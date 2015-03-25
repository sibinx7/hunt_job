Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, ENV['Facebook_KEY'],ENV['Facebook_SECRET']
  provider :twitter, 'API_KEY', 'API_SECRET'
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  provider :gplus, ENV['GPLUS_KEY'], ENV['GPLUS_SECRET']
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
end