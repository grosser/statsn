name = "statsn"
require "./lib/#{name}/version"

Gem::Specification.new name, Statsn::VERSION do |s|
  s.summary = "StatsN: Aggregate statistics using newrelics custom metrics"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files lib`.split("\n")
  s.license = "MIT"
  s.executables = ["statsn-calls"]
  s.add_runtime_dependency "newrelic_rpm", "~> 3.5"
end
