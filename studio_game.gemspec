
Gem::Specification.new do |s|
  s.name         = "studio_game_jarsenx"
  s.version      = "1.0.0"
  s.author       = "Joe Arsenault"
  s.email        = "jarsenx@gmail.com"
  s.homepage     = "https://github.com/jarsenx/studio_game"
  s.summary      = "Command line game for Ruby programming class."
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'studio_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end
