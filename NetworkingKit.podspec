Pod::Spec.new do |s|
  s.name             = 'NetworkingKit'
  s.version          = '0.2.0'
  s.summary          = 'This library is a simple networking layer with a easy integration with iOS App Extensions.'

  s.description      = 'This library was created with the purpose of creating a simple networking layer with a easy integration with iOS App Extensions. Although there\s a lot of networking managers, this class may be an opportunity to create new and custom libraries.'

  s.homepage         = 'https://github.com/BrunoMiguens/NetworkingKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bruno Miguens' => 'brunomiguens@icloud.com' }
  s.source           = { :git => 'https://github.com/BrunoMiguens/NetworkingKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'NetworkingKit/**/*'

end
