Pod::Spec.new do |s|
  s.name             = 'FFNetworking'
  s.version          = '0.1.0'
  s.summary          = 'HTTP networking framework built upon Alamofire.'
  s.description      = <<-DESC
FFNetworking is an HTTP networking framework built upon Alamofire in Swift. Doing just one request may seem more complicated than in Alamofire, but it proves itself in real projects.
                       DESC

  s.homepage         = 'https://github.com/Faifly/FFNetworking.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ArKalmykov' => 'ar.kalmykov@gmail.com' }
  s.source           = { :git => 'https://github.com/Faifly/FFNetworking.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'FFNetworking/Classes/**/*'
  s.dependency 'Alamofire'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
