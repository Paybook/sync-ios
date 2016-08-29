#
# Be sure to run `pod lib lint Paybook.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Paybook'
  s.version          = '1.0.9'
  s.summary          = 'Paybook is a library to take advantage of the Paybook Financial API (Sync).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    A library to take advantage of the Paybook Financial API (Sync) to pull information from Mexican Banks and Tax Authority.
                       DESC

  s.homepage         = 'https://github.com/Paybook/sync-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paybook Inc.' => 'gabriel@paybook.me' }
  s.source           = { :git => 'https://github.com/Paybook/sync-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'PaybookSync/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PaybookSync' => ['PaybookSync/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'Alamofire', '~> 3.4'
end
