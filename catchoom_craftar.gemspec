lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "catchoom_craftar/version"


Gem::Specification.new do |spec|
  spec.name          = "catchoom_craftar"
  spec.version       = CatchoomCraftar::VERSION
  spec.authors       = ["Cristi Stefan"]
  spec.email         = ["cristi.r.stefan@gmail.com"]

  spec.summary       = %q{A wrapper around the catchoom craftar management api.}
  spec.homepage      = "https://github.com/CristiRazvi/catchoom_craftar.git"
  spec.license       = "MIT"

  spec.files         = Dir["{bin,lib}/**/*", "README*", "LICENSE*", "Gemfile*", "Rakefile"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.11"
end


