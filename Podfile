source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!
use_frameworks!
platform :ios, '8.0'

def pods
    pod 'RealmSwift', '~> 2.4'
    pod 'ObjectMapper', '~> 2.2'
end

target 'RealmMapper' do  
    pods
    target 'Tests' do
        inherit! :search_paths
        pods
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
