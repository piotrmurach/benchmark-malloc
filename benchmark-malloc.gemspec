lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "benchmark/malloc/version"

Gem::Specification.new do |spec|
  spec.name          = "benchmark-malloc"
  spec.version       = Benchmark::Malloc::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["me@piotrmurach.com"]

  spec.summary       = %q{Trace memory allocations and collect stats.}
  spec.description   = %q{Trace memory allocations and collect stats.}
  spec.homepage      = "https://github.com/piotrmurach/benchmark-malloc"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/benchmark-malloc"
    spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/benchmark-malloc/CHANGELOG.md"
  end

  spec.files         = Dir['{lib,spec}/**/*.rb']
  spec.files        += Dir['tasks/*', 'benchmark-malloc.gemspec']
  spec.files        += Dir['README.md', 'CHANGELOG.md', 'LICENSE.txt', 'Rakefile']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency "bundler", ">= 1.17"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"
end
