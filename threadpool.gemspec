lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "threadpool/version"

Gem::Specification.new do |spec|
  spec.name          = "threadpool"
  spec.version       = Threadpool::VERSION
  spec.authors       = ["Zhon"]
  spec.email         = ["zhon@xmission.com"]

  spec.summary       = %q{A set of threads}
  spec.description   = %q{Go look at Wikipedia for a longer description. Duh!}
  spec.homepage      = "https://github.com/zhon/threadpool"

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/zhon/threadpool"
  spec.metadata["changelog_uri"] = "https://github.com/zhon/threadpool/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rr", "~> 1.2"
  spec.add_development_dependency "rantly", "~> 2"
  spec.add_development_dependency "guard", "~> 2.0"
  spec.add_development_dependency "guard-minitest", "~> 2.0"
end
