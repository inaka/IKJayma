#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "IKJayma"
  s.version          = 1.0
  s.summary          = "RESTful API abstraction for Server Interconnection"
  s.description      = "This library will allow you to make POST, PUT, DELETE and GET request from objects in an easy an fast way"
  s.homepage         = "http://github.com/inaka/IKJayma"
  #s.screenshots      = ""
  s.license          = 'MIT'
  s.author           = { "Andres Gerace" => "andres.gerace@inakanetworks.com" }
  s.source           = { :git => "git@github.com:inaka/IKJayma.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/inaka'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  #s.osx.deployment_target = '10.9'
  s.requires_arc = true

  s.source_files = 'Classes/ios/**/*.{h,m,swift}'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.frameworks = 'AFNetworking'
  s.dependency 'AFNetworking'
end
