lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "factory_bot_factory/version"

Gem::Specification.new do |spec|
  spec.name          = "factory_bot_factory"
  spec.version       = FactoryBotFactory::VERSION
  spec.authors       = ["cdragon"]
  spec.email         = "cdragon1116@gmail.com"
  spec.homepage      = "https://github.com/cdragon1116/factory_bot_factory"

  spec.summary       = "A Gem that geneartes FactoryBot Factory"
  spec.description   = "A Gem that geneartes FactoryBot Factory"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", '~> 0.13.1'
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "factory_bot"
end
