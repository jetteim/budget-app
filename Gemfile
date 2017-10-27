source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

group :development, :test, :production do
  gem 'dotenv-rails'
end

gem 'bcrypt'
gem 'colorize'
gem 'jbuilder'
gem 'pg'
gem 'pundit'
gem 'rack-cors'
gem 'redis'
gem 'redis-rails'
gem 'redis-store'
gem 'rest-client', '~> 2.0.2'
gem 'telegramAPI'
gem 'thin'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

#frontend
gem 'sass-rails'
gem 'jquery-rails'
gem 'ofx'
gem 'ejs'
gem 'kaminari'
gem 'active_model_serializers'
gem 'ice_cube'
gem 'bootstrap-sass'
gem 'responders'


group :development do
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
