Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['28542413a3d984f8813a'], ENV['f218f6e76e68e13b9ba79a4a98f499efe94e8529']
end