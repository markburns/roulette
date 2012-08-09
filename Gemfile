source 'https://rubygems.org'

gem 'rails', '3.2.6'

gem 'twilio-rb', git: 'git://github.com/markburns/twilio-rb.git'

gem 'pusher'
gem 'localtunnel'

group :test do
  gem 'rspec'
end

group :development do
  platforms :ruby do
    gem 'sqlite3'
  end
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
