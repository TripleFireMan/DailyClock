//
//  DKTargetSharedViewController.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/12.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKTargetSharedViewController.h"

@interface DKTargetSharedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgview;
@property (weak, nonatomic) IBOutlet UIButton *albumBtn;
@property (weak, nonatomic) IBOutlet UILabel *daylabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UIImageView *targetIcon;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *dakaDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *continueLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetLeftLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareToMore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConst;

- (IBAction)close:(id)sender;
- (IBAction)album:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)sharetoWechat:(id)sender;

- (IBAction)sharetoMore:(id)sender;

@end

@implementation DKTargetSharedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldShowHeader = NO;
    // Do any additional setup after loading the view from its nib.
    self.topConst.constant = CY_Height_StatusBar + 12;
    
}


- (IBAction)sharetoWechat:(id)sender {
}

- (IBAction)left:(id)sender {
}

- (IBAction)right:(id)sender {
}

- (IBAction)album:(id)sender {
}

- (IBAction)close:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sharetoMore:(id)sender {
}
@end
