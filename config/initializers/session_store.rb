# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_openoverflow_session',
  :secret      => 'e2c79a5f92b8933f504b25d4e35ddf6f9c28e53001aa30e59f9fba862ae7e3529822e46d7dfab172cff16598d13313703610d5d7a03aa4f5f0fb2f0be712f1b3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
