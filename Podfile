# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'RunningCrew' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for RunningCrew
    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'
    pod 'RxGesture', '4.0.4'
    pod 'NMapsMap', '3.15.0'
    pod 'SwiftLint', '0.48.0'
    pod 'SnapKit', '~> 5.6.0'
    pod 'FSCalendar'
    pod 'YPImagePicker'
    pod 'PryntTrimmerView'
    pod 'KakaoSDKAuth'
    pod 'KakaoSDKUser'
    pod 'KakaoSDKCommon'
    pod 'GoogleSignIn'
    pod 'Moya/RxSwift'
    pod 'FirebaseAuth'
    pod 'FirebaseFirestore'
    pod 'FirebaseMessaging'
    pod 'Kingfisher', '~> 7.0'
  target 'RunningCrewTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RunningCrewUITests' do
    # Pods for testing
  end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end


end
