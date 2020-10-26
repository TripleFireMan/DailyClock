//
//  DKAlert.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/17.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKAlert.h"
#import "FCAlertView.h"

NSInteger DKAlertDone = 100;

@interface DKAlert () <FCAlertViewDelegate>
@property (nonatomic, copy) void(^Click)(NSInteger idx, NSString *idxTitle);
@end

@implementation DKAlert


+ (void) showTitle:(NSString *)title subTitle:(NSString *)subTitle clickAction:(void (^)(NSInteger, NSString * _Nonnull))clickAction doneTitle:(NSString *)done array:(NSArray<NSString *> *)others{
    
    FCAlertView *alertView = [[FCAlertView alloc] init];
    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableAttributedString *subtitleAtt = [[NSMutableAttributedString alloc] initWithString:subTitle];
    titleAtt.font = DKBoldFont(20);
    titleAtt.color = [UIColor blackColor];
    
    subtitleAtt.font = DKFont(14);
    subtitleAtt.color = [UIColor blackColor];
    
    [alertView showAlertWithAttributedTitle:titleAtt withAttributedSubtitle:subtitleAtt withCustomImage:nil withDoneButtonTitle:@"确定" andButtons:@[@"取消"]];
    
    alertView.cornerRadius = 18.f;
    alertView.detachButtons = YES;
    alertView.colorScheme = kMainColor;
    alertView.doneButtonTitleColor  = [UIColor blackColor];
//    alertView.doneButtonHighlightedBackgroundColor = kMainColor;
    alertView.doneButtonCustomFont = DKFont(15.f);
    alertView.firstButtonCustomFont = DKFont(15.f);
//    alertView.doneButtonTitleColor = [UIColor blackColor];
//    alertView.firstButtonBackgroundColor = [UIColor lightTextColor];
    alertView.firstButtonTitleColor = [UIColor blackColor];
    alertView.hideSeparatorLineView = YES;
    
    
    alertView.delegate = [DKAlert cy_shareInstance];
    [DKAlert cy_shareInstance].Click = clickAction;
//    [[[DKAlert cy_shareInstance] rac_signalForSelector:@selector(FCAlertView:clickedButtonIndex:buttonTitle:) fromProtocol:@protocol(FCAlertViewDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
//        NSNumber *first = [x second];
//        NSString *titles = [x third];
//        clickAction?clickAction([first intValue],titles):nil;
//    }];
//
//
//    [[[DKAlert cy_shareInstance] rac_signalForSelector:@selector(FCAlertDoneButtonClicked:) fromProtocol:@protocol(FCAlertViewDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
//        clickAction?clickAction(DKAlertDone,done):nil;
//    }];
}

- (void) FCAlertDoneButtonClicked:(FCAlertView *)alertView{
    if (self.Click) {
        vibrate();
        self.Click(DKAlertDone, nil);
    }
}

- (void) FCAlertView:(FCAlertView *)alertView clickedButtonIndex:(NSInteger)index buttonTitle:(NSString *)title
{
    if (self.Click) {
        vibrate();
        self.Click(index, title);
    }
}
@end
