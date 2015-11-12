#
# Be sure to run `pod lib lint KFRFuzzyDateTranslator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KFRFuzzyDateTranslator"
  s.version          = "0.1.0"
  s.summary          = "A objective-c cocoapod that converts NSStrings to NSDate objects."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC 
  This pod was developed to convert a NSString into a NSDate object so you dont have to use that date spinner anymore! Yay. The string "next Monday" returns the NSDate object of the next Monday, relative to today. The class interprets fuzzy human readable words to an exact date at midnight. Currently, the days of the week are supported with the prefix "next", "this", or "last", as well as the words "yesterday", "tomorrow", and "today".
                       DESC

  s.homepage         = "https://github.com/kiaraRobles/KFRFuzzyDateTranslator"
  # s.screenshots     = "http://imgur.com/2bl8bRK.png", "http://imgur.com/4S8B91p.png", "http://imgur.com/TgSAweE.png"
  s.license          = 'MIT'
  s.author           = { "kiaraRobles" => "kiara.robles@gmail.com" }
  s.source           = { :git => "https://github.com/kiaraRobles/KFRFuzzyDateTranslator.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/anarchoass'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'KFRFuzzyDateTranslator' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
