# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Dcoder' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'PINRemoteImage'
  pod 'TagListView', '~> 1.0'
  pod 'DropDown', '2.3.2'

  # Pods for Dcoder

  target 'DcoderTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DcoderUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
    end
end
