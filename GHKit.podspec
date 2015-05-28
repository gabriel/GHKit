Pod::Spec.new do |s|

  s.name         = "GHKit"
  s.version      = "2.0.0"
  s.summary      = "Objective-C categories and utilities"
  s.homepage     = "https://github.com/gabriel/GHKit"
  s.license      = "MIT"
  s.author       = { "Gabriel Handford" => "gabrielh@gmail.com" }
  s.source       = { :git => "https://github.com/gabriel/GHKit.git", :tag => s.version.to_s }

  s.ios.platform = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.ios.source_files = "GHKit", "GHKit/iOS"

  s.osx.platform =  :osx, "10.8"
  s.osx.deployment_target = "10.8"
  s.osx.source_files = "GHKit"

  s.requires_arc = true

end
