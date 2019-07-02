#
#  Be sure to run `pod spec lint InjectPropertyWrapper.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name          = "InjectPropertyWrapper"
  spec.version       = "0.2.0"
  spec.author        = { "Peter Verhage" => "peter@egeniq.com" }
  spec.homepage      = "https://github.com/egeniq/InjectPropertyWrapper"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.summary       = "Provides a Swift @Inject property wrapper to inject objects from a DI framework."
  spec.description   = <<-DESC
    Provides a generic Swift @Inject property wrapper that can be used to inject objects / services from
    a dependency injection framework of your choice.
  DESC

  spec.swift_version         = '5.1'
  spec.ios.deployment_target = '9.0'
  spec.osx.deployment_target = '10.9'
  
  spec.source        = { :git => "https://github.com/egeniq/InjectPropertyWrapper.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources", "Sources/**/*.swift"
end
