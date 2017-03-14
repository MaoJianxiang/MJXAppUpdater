#
# Be sure to run `pod lib lint MJXAppUpdater.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MJXAppUpdater'
  s.version          = '1.2'
  s.summary          = 'Prompt the user version to upgrade'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a framework used to remind the user can update.
                       DESC

  s.homepage         = 'https://github.com/MaoJianxiang/MJXAppUpdater'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mao Jianxiang' => '15208105440@163.com' }
  s.source           = { :git => 'https://github.com/MaoJianxiang/MJXAppUpdater.git', :tag => 1.2 }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MJXAppUpdater/Classes/*'
  
  # s.resource_bundles = {
  #   'MJXAppUpdater' => ['MJXAppUpdater/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/MJXAppUpdater.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
