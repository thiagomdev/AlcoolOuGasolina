platform :ios, '17.6'

target 'GasTypeApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GasTypeApp
    pod 'IQKeyboardManagerSwift'

  target 'GasTypeAppTests' do
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.6'
    end
  end
end
