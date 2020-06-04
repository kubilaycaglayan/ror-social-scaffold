Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  "501350442601-533uen6u4h8ulk758jfjqrmj3k5jeqcf.apps.googleusercontent.com",
   "jlmsxp_QtGxdS-Fl3Eh48lTc", skip_jwt: true
end
