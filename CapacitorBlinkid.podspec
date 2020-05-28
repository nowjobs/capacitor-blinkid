
  Pod::Spec.new do |s|
    s.name = 'CapacitorBlinkid'
    s.version = '0.0.1'
    s.summary = 'A Capacitor plugin for the native Microblink BlinkID SDK.'
    s.license = 'MIT'
    s.homepage = 'https://github.com/nowjobs/capacitor-blinkid'
    s.author = 'NOWJOBS'
    s.source = { :git => 'https://github.com/nowjobs/capacitor-blinkid', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
    s.dependency 'PPBlinkID'
    s.resources = "*.jpeg" # mock id
  end