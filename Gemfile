source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.0.1'

gem 'jbuilder'
gem 'mysql2'
gem 'puma'
gem 'haml'

group :development, :test do
  gem 'byebug'
  gem 'pry'
end

group :development do
  gem 'listen'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'rspec-rails'
end
