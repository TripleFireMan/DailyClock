platform :ios, '9.0'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
#source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!

def DKPods()
  pod 'CYKit',:git => 'https://github.com/TripleFireMan/CYKit.git'
  pod 'Masonry', '1.1.0'
  pod 'SDWebImage', '5.5.2'
  pod 'IQKeyboardManager', '6.4.2'                                 #键盘处理
  pod 'PromisesObjC','1.2.8'
  pod 'FastCoding','3.3'
  pod 'YYKit'
  pod 'CYLTabBarController/Lottie', '1.28.3'
  pod 'ZWPlaceHolder'
  pod 'ZWLimitCounter','0.0.2'
  pod 'JPush', '~> 3.1.0'
  pod 'FSCalendar'
  pod 'FCAlertView'
  pod 'MBProgressHUD'
  pod 'UMCCommon','7.1.3'
  pod 'SnapKit'
end

target 'DailyClock' do
  DKPods()
end

target 'DailyClockUITests' do
  DKPods()
end
