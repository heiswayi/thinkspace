Gem::Specification.new do |spec|
	spec.name          = "blog"
	spec.version       = "2.5.0"
	spec.authors       = ["Rodrigo Gruber"]
	spec.email         = ["736d9d13-b432-45b3-a5e5-f012126caca9@gruber.anonaddy.com"]

	spec.summary       = "A collection of notes regarding pharmacology, new-tech, open-source projects and personal thoughts."
	spec.homepage      = "https://verifiedgruber.github.io/blog/"
	spec.license       = "MIT"

	spec.metadata["plugin_type"] = "theme"

	spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|(LICENSE|README)((\.(txt|md|markdown)|$)))!i) }

	spec.add_runtime_dependency "jekyll", "~> 4.0.0"

	#spec.add_development_dependency "bundler", "~> 2.0.1"
	spec.add_development_dependency "rake", "~> 12.0"
end

