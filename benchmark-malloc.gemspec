require_relative "lib/benchmark/malloc/version"

Gem::Specification.new do |spec|
  spec.name          = "benchmark-malloc"
  spec.version       = Benchmark::Malloc::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{Trace memory allocations and collect stats.}
  spec.description   = %q{Trace memory allocations and collect stats.}
  spec.homepage      = "https://github.com/piotrmurach/benchmark-malloc"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
    spec.metadata["bug_tracker_uri"] = "https://github.com/piotrmurach/benchmark-malloc/issues"
    spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/benchmark-malloc/CHANGELOG.md"
    spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/benchmark-malloc"
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/benchmark-malloc"
  end
  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.1.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
