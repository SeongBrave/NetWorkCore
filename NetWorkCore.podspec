#
# Be sure to run `pod lib lint NetWorkCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NetWorkCore'
  s.version          = '0.0.1'
  s.summary          = 'RxSwift封装网络请求'


  s.description      = <<-DESC
TODO: RxSwift封装络请求封， 包含了网络请求，数据解析等...
                       DESC

  s.homepage         = 'https://github.com/seongbrave/NetWorkCore'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'seongbrave' => 'seongbrave@sina.com' }
  s.source           = { :git => 'https://github.com/seongbrave/NetWorkCore.git', :tag => s.version.to_s }
  s.social_media_url = 'http://seongbrave.github.io/'

  s.ios.deployment_target = '8.0'

  s.source_files  = 'NetWorkCore/Classes/**/*.{swift}'

  s.frameworks = 'UIKit'
  s.dependency 'ModelProtocol', '~> 0.0.1'
  s.dependency 'RxSwift', '~> 4.1.2'  #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
  s.dependency 'RxCocoa', '~> 4.1.2'
  s.dependency 'Alamofire', '~> 4.7.0'
  s.dependency 'Result', '~> 3.2.4'
  
  # s.resource_bundles = {
  #   'NetWorkCore' => ['NetWorkCore/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
