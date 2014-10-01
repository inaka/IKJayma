#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "IKJayma"
  s.version          = "1.1.1"
  s.source           = { :git => "git@github.com:inaka/IKJayma.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/inaka'
  s.authors =  { 'Andres Gerace' => 'andres.gerace@inakanetworks.com' }
  s.homepage = "https://github.com/inaka"
  s.license = { :type => 'BSD' }
  s.requires_arc = true
  s.source_files  = 'IKJayma/IKJayma/*.{h,m}'

  #s.frameworks = 'Facebook-iOS-SDK'
  s.platform = :ios, '7.0'
  s.dependency 'AFNetworking'

  s.summary          = "IKJayma is a RESTful API abstraction for Server Interconnection."
  s.description      = "IKJayma was developed to ease the way we connect with the server. This will provide an easy way to create, update, delete and get entities from a server in a few lines of code."
end