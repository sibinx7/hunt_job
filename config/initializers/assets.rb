# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( slides.js )
Rails.application.config.assets.precompile += %w( owl.carousel.js )
Rails.application.config.assets.precompile += %w( custom.modernizer.js )
Rails.application.config.assets.precompile += %w( dropzone.min.js )

Rails.application.config.assets.precompile += %w( owl.carousel.css )
Rails.application.config.assets.precompile += %w( owl.theme.css )
Rails.application.config.assets.precompile += %w( owl.transitions.css )

Rails.application.config.assets.precompile += %w( jquery.tagit.css )
Rails.application.config.assets.precompile += %w( tagit.ui-zendesk.css )
Rails.application.config.assets.precompile += %w( user_extras )