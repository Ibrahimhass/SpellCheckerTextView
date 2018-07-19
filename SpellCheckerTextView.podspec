#
# Be sure to run `pod lib lint SpellCheckerTextView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpellCheckerTextView'
  s.version          = '0.1.0'
  s.summary          = 'A UITextView subclass which detects and highlights words with incorrect spellings. Uses UISpellChecker and NSLinguistic Tagger.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '
  A UITextView subclass which detects and highlights words with incorrect spellings. The language is determined using the Device Language. Uses UISpellChecker and NSLinguistic Tagger. Written entirely in Swift 4.1.'

  s.homepage         = 'https://github.com/Ibrahimhass/SpellCheckerTextView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ibrahimhass' => 'mdibrahimhassan@gmail.com' }
  s.source           = { :git => 'https://github.com/Ibrahimhass/SpellCheckerTextView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/IbrahimH_ss_n'

  s.ios.deployment_target = '11.0'

  s.source_files = 'SpellCheckerTextView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SpellCheckerTextView' => ['SpellCheckerTextView/Assets/*.png']
  # }
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
