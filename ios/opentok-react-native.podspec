require 'json'

package = JSON.parse(File.read(File.join(__dir__, '../', 'package.json')))

Pod::Spec.new do |s|
  s.name                = package['name']
  s.version             = package['version']
  s.summary             = package['description']
  s.homepage            = package['homepage']
  s.license             = package['license']
  s.authors             = package['author']
  s.source              = { :git => package['repository']['url'] }
  s.platform            = :ios, '9.0'
  s.swift_version       = '4.0'
  s.source_files        = 'OpenTokReactNative/**/*.{h,m,swift}'
  s.static_framework    = true # Needed so we don't get the `transitive dependencies that include static binaries` error
  # s.dependency          'React'
  # Workaround CocoaPods error when React is set as an explicit dependency
  # `The Swift pod `opentok-react-native` depends upon `React`, which do not define modules.`
  # Cause the recommended action (`use_modular_headers!` globally in your Podfile, or specify `:modular_headers => true` for particular dependencies.)
  # doesn't work with the React pod
  s.pod_target_xcconfig = { 'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/Headers/Public/React"' }
  s.dependency          'OpenTok'
end
