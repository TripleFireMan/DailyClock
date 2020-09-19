//
//  URL.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/19.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#ifndef URL_h
#define URL_h

#ifdef DEBUG
//#define HOST        @"http://0.0.0.0:8000/"
#define HOST        @"http://192.168.0.102:8000/"
#else
#define HOST        @"http://chengyan.shop/"
#endif

#define FeedBack    HOST@"dailyClock/feedBack?"
#define UploadImge  HOST@"save_profile?"


#endif /* URL_h */
