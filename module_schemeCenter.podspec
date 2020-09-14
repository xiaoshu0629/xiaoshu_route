#
# Be sure to run `pod lib lint module_schemeCenter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'module_schemeCenter'
  s.version          = '0.0.1'
  s.summary          = 'route jump'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https:/xiaoyezi.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaoshu_ios@163.com' => 'xiaoshu@xiaoyezi.com' }
  s.source           = { :git => 'ssh://xiaoshu@codereview.xiaoyezi.com:29418/module_schemeCenter', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.subspec 'ModuleServiceCenter' do |ss|

  ss.source_files = 'module_schemeCenter/ModuleServiceCenter/**/*.{h,m}'

  ss.public_header_files = "module_schemeCenter/ModuleServiceCenter/**/*.{h}"

  end
  s.subspec 'URLSchemeCenter' do |ss|

  ss.source_files = 'module_schemeCenter/URLSchemeCenter/**/*.{h,m}'

  ss.public_header_files = "module_schemeCenter/URLSchemeCenter/**/*.{h}"

  end
  
  # s.resource_bundles = {
  #   'module_schemeCenter' => ['module_schemeCenter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
