# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_basic_cms_session',
  :secret      => '7fd5541802fc4df737a0ba43023e8197208f00b047d245fcafd62527c82fe93fa207674436edeaf5b72d260bf940e217a2068af868715feecefb3e65efd0d896'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
