source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.4'
gem 'pg' # postgres

# Use SCSS for stylesheets
gem "sass-rails", "~> 4.0.2"
gem 'bootstrap-sass', '~> 3.1.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'i18n_generators'
gem 'cancan'
gem 'devise'
gem 'devise_invitable'
gem 'figaro'
gem 'rolify'
gem 'simple_form', '>= 3.0.0.rc'
gem 'nokogiri' # is an HTML, XML, SAX, and Reader parser. Among Nokogiri's many features is the ability to search documents via XPath or CSS3 selectors
gem 'json'
gem 'protected_attributes'
gem 'slim-rails'
gem 'workflow', git: 'https://github.com/geekq/workflow'

gem "kaminari", "~> 0.14.1" # pagination
gem 'bootstrap-kaminari-views'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms => [:mri_19, :mri_20, :rbx]
  gem 'guard', "~> 2.0.3"
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'quiet_assets'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'thin'
  gem 'rack-mini-profiler' # displays time spent on requests
end
group :development, :test do
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-doc'

  gem 'rspec-rails'
  gem 'factory_girl_rails'

  gem 'database_cleaner', '1.0.1'
  gem 'letter_opener'
  gem 'faker'
  gem 'mago' # magic numbers detector
end
group :production do
  gem 'rails_12factor'
  gem "passenger", '>= 4.0.18' # for heroku
  gem 'rollbar' # monitoring
  gem 'newrelic_rpm' # monitoring
end
group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'email_spec'
  gem "simplecov", require: false
end

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
