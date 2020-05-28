
  Pod::Spec.new do |s|
    s.name = 'CapacitorPluginBlinkid'
    s.version = '0.0.1'
    s.summary = 'A Capacitor plugin for BlinkID'
    s.license = 'MIT'
    s.homepage = 'https://bitbucket.org/nowjobsdev/capacitor-blinkid/'
    s.author = 'Olivier Overstraete'
    s.source = { :git => 'https://bitbucket.org/nowjobsdev/capacitor-blinkid/', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
    s.dependency 'PPBlinkID'
    s.resources = "*.jpeg" # mock id
  end
