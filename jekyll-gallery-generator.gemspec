Gem::Specification.new do |spec|
  spec.name        = "jekyll-gallery-generator"
  spec.summary     = "Generate galleries with thumbnails for your Jekyll site."
  spec.version     = "1.1.0"
  spec.authors     = ["Geoff Greer"]
  spec.email       = "geoff@greer.fm"
  spec.homepage    = "https://github.com/ggreer/jekyll-gallery-generator"
  spec.licenses    = ["Apache-2.0"]

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.requirements << "imagemagick, >=v6.9 (needed by RMagick)"

  spec.add_runtime_dependency "exifr", "~> 1.2"
  spec.add_runtime_dependency "rmagick", "~> 2.12"

  spec.add_development_dependency "jekyll", "~> 2.0"
  spec.add_development_dependency "bundler", "~> 1.6"
end
