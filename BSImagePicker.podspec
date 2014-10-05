Pod::Spec.new do |s|
  s.name         = "BSImagePicker"
  s.version      = "0.6.1"
  s.summary      = "BSImagePicker is a multiple image picker for iOS"
  s.description  = <<-DESC
  A mix between the native iOS 7 gallery and facebooks image picker. Allows you to preview and select multiple images.
                   DESC
  s.homepage     = "https://github.com/mikaoj/BSImagePicker"
  s.license      = "MIT"
  s.author             = { "Joakim Gyllström" => "joakim@backslashed.se" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/mikaoj/BSImagePicker.git", :tag => "0.6.1" }
  s.source_files  = "BSImagePicker/**/*.{h,m}"
  s.exclude_files = "BSImagePicker/Controller/BSAppDelegate.{h,m}", "BSImagePicker/Misc/main.m"

  s.requires_arc = true
  s.frameworks = 'AssetsLibrary', 'UIKit', 'MediaPlayer'
  s.screenshots = ["https://cloud.githubusercontent.com/assets/4034956/3030011/c7d86756-e03b-11e3-87b8-d682142967c2.png",
                   "https://cloud.githubusercontent.com/assets/4034956/3030009/c7d4c1b4-e03b-11e3-8cc7-bda50c85dd46.png",
                   "https://cloud.githubusercontent.com/assets/4034956/3030010/c7d6ddd2-e03b-11e3-8c50-03f92a99e47e.png",
                   "https://cloud.githubusercontent.com/assets/4034956/3030008/c7915686-e03b-11e3-8e1f-cc8aa8680a6a.png"]
end

