platform :ios, '14.0'

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end


def firebase
  pod 'Firebase/Core', '~> 7.10.0'
  pod 'Firebase/Database', '~> 7.10.0'
  pod 'Firebase/Auth', '~> 7.10.0'
  pod 'Firebase/Firestore', '~> 7.10.0'
end


target 'PerfectApp_Colchugina' do
  
  use_frameworks!

  inhibit_all_warnings!

  firebase

end
