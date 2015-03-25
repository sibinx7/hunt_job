# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :developer unless Rails.env.production?
#   provider :facebook, ENV['1379195339071579'],ENV['860b7087d925f0debbec605d694505e8']
#   provider :twitter, 'API_KEY', 'API_SECRET'
#   provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
#   provider :gplus, ENV['GPLUS_KEY'], ENV['GPLUS_SECRET']
#   provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
# end