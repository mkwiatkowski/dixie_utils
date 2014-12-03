$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dixie_utils/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dixie_utils"
  s.version     = DixieUtils::VERSION
  s.authors     = ["Michal Kwiatkowski"]
  s.email       = ["michal@trivas.pl"]
  s.homepage    = "https://github.com/mkwiatkowski/dixie_utils"
  s.summary     = "Dixie util"
  s.description = "A set of utilities for Dixie apps."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
