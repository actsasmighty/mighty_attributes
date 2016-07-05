source "https://rubygems.org"

gemspec

group :development do
  gem "bundler"
  gem "rake"
  gem "rspec", "~> 3.0"
  gem "simplecov"

  # activesupport
  if RUBY_VERSION < "2.2.2"
    gem "activemodel", "< 5"
    gem "activesupport", "< 5"
  else
    gem "activemodel"
    gem "activesupport"
  end

  # json (implicit dependency)
  if RUBY_VERSION <= "1.9.3"
    gem "json", "< 2"
  end

  if !ENV["CI"] && RUBY_ENGINE == "ruby"
    gem "pry"

    if RUBY_VERSION < "2.0.0"
      gem "pry-nav"
    else
      gem "pry-byebug"
    end

    gem "pry-syntax-hacks"
  end
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end
