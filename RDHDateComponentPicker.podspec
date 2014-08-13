Pod::Spec.new do |s|
  s.name             = "RDHDateComponentPicker"
  s.version          = "0.1.0"
  s.summary          = "A short description of RDHDateComponentPicker."
  s.description      = <<-DESC
                       An optional longer description of RDHDateComponentPicker

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/RDHDateComponentPicker"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Rich Hodgkins" => "rhodgkins@gmail.com" }
  s.source           = { :git => "https://github.com/rhodgkins/RDHDateComponentPicker.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rhodgkins'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'RDHDateComponentPicker/'
  s.private_header_files = 'RDHDateComponentPicker/Internal/**/*.h'
  
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
end
