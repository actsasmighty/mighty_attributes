$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

if ENV["CODECLIMATE_REPO_TOKEN"]
  # report coverage only for latest mri ruby
  if RUBY_ENGINE == "ruby" && RUBY_VERSION >= "2.3.0"
    require "codeclimate-test-reporter"
    CodeClimate::TestReporter.start
  end
else
  require "simplecov"
  SimpleCov.start
end

require "mighty_attributes"

begin
  require "pry"
rescue LoadError
end

