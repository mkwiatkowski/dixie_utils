# Dixie utils

## Installing into a Rails app

To install, follow these steps:

1. Put the following into your Gemfile:

```
group :development, :test do
  gem 'dotenv-rails'
end
```

2. Put this at the end of the Gemfile:

```
gem 'dixie_utils', git: 'git://github.com/mkwiatkowski/dixie_utils.git'
```

This line needs to be lower than the `gem "dotenv"` line.

3. Remove `config/initializers/session_store.rb` file. The gem takes care of configuring the session store.

4. Create `.env` file at the root of the project with the following contents:

```
SECRET_KEY_BASE=ecb175b36a26139a9a4c1b056100ee77f8757aa465a57c42bfa828e785faaac67984b4c062b9b1a3b4c5286228d4d63cc574e76d023d54f01b19f0cd73e7096e
AUTH_URL=http://auth.localhost.com:3000/
DOMAIN=localhost.com
```

5. Change development config in `config/secrets.yml` into:

```
development:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

6. Put the following line inside your `ApplicationController` class:

```
include DixieUtils::Authentication
```

7. Add `<%= logout_button %>` somewhere in the views.

8. Start your app with `rails s -p 3001` and see your app in browser through `http://app.localhost.com:3001`. You will need to setup your `/etc/hosts` with those domains to make it work. If dixie-auth app is running on 3000 you will be able to login and then get redirected back to your app.

9. Before deployment to production make sure `SECRET_KEY_BASE` and `DOMAIN` environment variables are defined on Heroku and have the same values as the dixie-auth app. `AUTH_URL` env variable needs to point to the production address of the dixie-auth app.

## Updating

Whenever there is a new version, run the following command in your project directory:

```
bundle update dixie_utils
```
