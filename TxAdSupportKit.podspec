#
# Be sure to run `pod lib lint TxAdSupportKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TxAdSupportKit'
  s.version          = '4.16.1'
  s.summary          = 'TxAdSupportKit 是一个 CSJGromre 的集成 SDK。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  TxAdSupportKit 是一个 SDK 广告类库，方便集成穿山甲、优量汇、快手等。
                       DESC

  s.homepage         = 'https://github.com/Bogon/TxAdSupportKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bogonchar' => 'zhangqixcu@gmail.com' }
  s.source           = { :git => 'https://github.com/Bogon/TxAdSupportKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.static_framework = true
  s.ios.deployment_target = '12.0'
  s.swift_version = '4.2'

  s.source_files = 'TxAdSupportKit/Classes/**/*'
  s.resource_bundles = {
    'TxAdSupportKit' => ['TxAdSupportKit/Assets/PrivacyInfo.xcprivacy']
  }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.dependency 'Ads-CN-Beta', '7.1.0.3'
  # 注意：如果需要指定子模块（subspec），写法如下
  s.dependency 'Ads-CN-Beta/CSJMediation', '7.1.0.3'

  # 引入融合适配器
  s.dependency 'GMGdtAdapter-Beta', '4.15.41.1'
  s.dependency 'GMKsAdapter-Beta', '4.6.30.1.1'

  # 引入 ADN SDK
  s.dependency 'GDTMobSDK', '4.15.41'
  s.dependency 'KSAdSDK', '4.6.30.1'
  
end
