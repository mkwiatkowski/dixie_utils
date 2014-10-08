module DixieUtils
  class Railtie < Rails::Railtie
    config.before_initialize do
      if ENV['DOMAIN'].blank?
        raise RuntimeError.new('Environment variable DOMAIN not set. Set it in .env during development (see .env.sample for an example) and via `heroku config:set` on production.')
      end

      if ENV['AUTH_URL'].blank?
        raise RuntimeError.new('Environment variable AUTH_URL not set. Set it in .env during development (see .env.sample for an example) and via `heroku config:set` on production.')
      end

      ::Rails.configuration.session_store(:cookie_store,
        expire_after: 1.month,
        key: '_dixie-auth_session',
        domain: ENV['DOMAIN'])
    end
  end
end
