source "https://rubygems.org"

gemspec

group :development do
  gem "bundler"
  gem "rake"
  gem "rspec", "~> 3.0"
  gem "simplecov"

  if !ENV["CI"] && RUBY_ENGINE == "ruby"
    gem "pry"
    gem "pry-byebug"
    gem "pry-syntax-hacks"
  end
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end
