require_relative "lib/satanic_pages/version"

Gem::Specification.new do |spec|
  spec.name = "satanic_pages"
  spec.version = SatanicPages::VERSION
  spec.authors = ["Mikkel Malmberg"]
  spec.email = ["mikkel@brnbw.com"]
  spec.homepage = "https://github.com/mikker/satanic_pages"
  spec.summary = "An embeddable static pages engine for Rails apps and the devil"
  spec.description = "An embeddable static pages engine for Rails apps and the devil"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency("ostruct", ">= 0.6")
  spec.add_dependency("rails", ">= 7")
end
