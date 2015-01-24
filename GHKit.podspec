Pod::Spec.new do |s|

  s.name         = "GHKit"
  s.version      = "1.0.20"
  s.summary      = "Objective-C categories and utilities"
  s.homepage     = "https://github.com/gabriel/gh-kit"
  s.license      = "MIT"
  s.author       = { "Gabriel Handford" => "gabrielh@gmail.com" }
  s.source       = { :git => "https://github.com/gabriel/gh-kit.git", :tag => s.version.to_s }

  s.ios.platform = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.ios.source_files = "Classes", "Classes/iOS"

  s.osx.platform =  :osx, "10.8"
  s.osx.deployment_target = "10.8"
  s.osx.source_files = "Classes"

  s.requires_arc = true

end
