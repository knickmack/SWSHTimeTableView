Pod::Spec.new do |s|
  s.name         = "SWSHTimeTableView"
  s.version      = "0.0.1"
  s.summary      = "SWSHTimeTableView is an Objective-C time table view for your apps."
  s.homepage     = "http://www.swiii.sh"
  s.license      = "MIT"
  s.author       = { "Nik Macintosh" => "nmacintosh@swiii.sh" }
  s.source       = { :git => "https://github.com/knickmack/SWSHTimeTableView.git", :tag => "0.0.1" }
  s.platform     = :ios, "6.0"
  s.source_files = "SWSHTimeTableView", "SWSHTimeTableView/*.{h,m}"
  s.framework    = "CoreText"
  s.requires_arc = true
end
