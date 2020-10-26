//
//  Macro.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/26.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#import <UIKit/UIKit.h>
static AVAudioPlayer * movePlayer = nil;
//static AVAudioPlayer * avplayer(){
//    static AVAudioPlayer *player = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        player = [[AVAudioPlayer alloc] init];
//        player.url =
//    });
//}

static inline void vibrate(){
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10, *)) {
            // 初始化震动反馈类
            if (![DKApplication cy_shareInstance].forbidVibrate) {
                UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
                // 准备
                [generator prepare];
                // 调用
                [generator impactOccurred];
            }
        } else {
            
        }
    });
}

static inline void music(){
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSURL *system_sound_url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"jingle" ofType:@"aac"]];
//        // 第一步 创建 SystemSoundID
//        SystemSoundID system_sound_id;
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)system_sound_url, &system_sound_id);
//        // 第二步 播放系统声音
//        AudioServicesPlaySystemSound(system_sound_id);
        
        


        NSURL*moveMP3=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"jingle" ofType:@"aac"]];

        NSError*err=nil;

        movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];

        [movePlayer prepareToPlay];
        if(err!=nil) {
        }else{
            [movePlayer play];
        }
    });
}

static inline void playMusic(NSString *musicName){
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL*moveMP3=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:musicName?:@"jingle" ofType:@"aac"]];

        NSError*err=nil;

        movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];

        [movePlayer prepareToPlay];
        if(err!=nil) {
        }else{
            [movePlayer play];
        }
    });
}



#endif /* Macro_h */
