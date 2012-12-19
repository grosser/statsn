$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "statsn"
require "#{name}/version"

Gem::Specification.new name, Statsn::VERSION do |s|
  s.summary = "StatsN: Aggregate statistics using newrelics custom metrics"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "http://github.com/grosser/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
end
