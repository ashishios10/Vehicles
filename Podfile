# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Vehicles' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
    pod 'FTIndicator', '1.2.9'

  # Pods for Vehicles

  target 'VehiclesTests' do
    inherit! :search_paths
    # Pods for testing    
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.2'
            end
        end
    end
end
