Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch("TWITTER_KEY"), ENV.fetch("TWITTER_SECRET"), callback_url: "http://localhost:3000/omniauth/twitter/callback"
  provider :facebook, ENV.fetch("FACEBOOK_ID"), ENV.fetch("FACEBOOK_SECRET_KEY"), callback_url: "http://localhost:3000/omniauth/facebook/callback"
  provider :google_oauth2, ENV.fetch("GOOGLE_CLIENT_ID"), ENV.fetch("GOOGLE_CLIENT_SECRET"), callback_url: "http://localhost:3000/omniauth/google_oauth2/callback"
end