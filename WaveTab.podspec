#
# Be sure to run `pod lib lint WaveTab.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WaveTab'
  s.version          = '0.1.3'
  s.summary          = 'A wave UITabBarController.'
  s.description      = <<-DESC
A UITabBarController that moves like a wave as the user switches between tabs
                       DESC

  s.homepage         = 'https://github.com/mapierce/WaveTab'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matthew Pierce' => 'mp.mapierce@gmail.com' }
  s.source           = { :git => 'https://github.com/mapierce/WaveTab', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/PierceMatthew'
  s.ios.deployment_target = '10.0'
  s.source_files = 'WaveTab/Classes/**/*'
  s.swift_version = '4.2'
  s.frameworks = 'UIKit'
end
