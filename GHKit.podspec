#
#  Be sure to run `pod spec lint GHUIKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "GHKit"
  s.version      = "1.0.0"
  s.summary      = "Objective-C categories and utilities"
  s.homepage     = "https://github.com/gabriel/gh-kit"
  s.license      = 'MIT'
  s.author       = { "Gabriel Handford" => "gabrielh@gmail.com" }
  s.source       = { :git => "https://github.com/gabriel/gh-kit.git", :tag => "1.0.0" }
  s.platform     = :ios, '7.0'
  s.source_files = 'Classes', 'Classes/iOS'

end
