#
#  Be sure to run `pod spec lint BlipChat.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "BlipChat"
  s.version      = "2.0.9"
  s.summary      = "A Swift Framework to easly add BLiP conversations in your iOS app. For more information see BLiP portal and BLiP documentation."

  s.homepage     = "https://github.com/takenet/blip-chat-ios"
  s.documentation_url = 'https://github.com/takenet/blip-chat-ios'
  s.license      = { :type => 'Apache-2', :file => 'LICENSE' }

  s.author             = { "Take" => "op.blip.app@take.net" }

  s.platform     = :ios
  s.ios.deployment_target  = "10.0"

  s.source       = { :git  => "https://github.com/takenet/blip-chat-ios" , :tag => "2.0.9" }
  s.source_files = "BlipChat/**/*.swift", "BlipChat/*.storyboard"
  s.resource_bundles = {
    "BlipChat" => ["BlipChat/*.xcassets", "BlipChat/*.html"]
  }
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.2" }

end
