//
//  CYBaseNavigationBar.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/16.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "CYBaseNavigationBar.h"

@implementation CYBaseNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        @weakify(self);
        self.headerView = [UIView new];
        self.headerView.backgroundColor = [UIColor redColor];
        [self addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(0);
            make.height.offset(CY_Height_NavBar);
        }];
        
        self.heaerImageView =[UIImageView new];
        self.heaerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.heaerImageView.clipsToBounds = YES;
        [self.headerView addSubview:self.heaerImageView];
        [self.heaerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        self.heaerImageView.hidden = YES;
        
        
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        UIImage *bgImage = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.backBtn setImage:bgImage forState:UIControlStateNormal];
        [self.backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
        [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        self.backBtn.tintColor = [UIColor whiteColor];
        [[self.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.backAction? self.backAction():nil;
            
        }];
        [self.headerView addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.bottom.offset(-5);
            make.height.width.offset(40);
        }];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.headerView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backBtn);
            //        make.centerX.mas_equalTo(self.headerView);
            make.left.mas_equalTo(self.backBtn.mas_right).offset(10);
            make.right.offset(-60);
        }];
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        self.bottomLine = [UIView new];
        self.bottomLine.backgroundColor = RGBColor(200, 200, 200);
        [self.headerView addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(CY_Sigle_Line_Height);
        }];
        
        self.bottomLine.hidden = YES;
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.headerView = [UIView new];
        self.headerView.backgroundColor = [UIColor redColor];
        [self addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(0);
            make.height.offset(CY_Height_NavBar);
        }];
        
        self.heaerImageView =[UIImageView new];
        self.heaerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.heaerImageView.clipsToBounds = YES;
        [self.headerView addSubview:self.heaerImageView];
        [self.heaerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        self.heaerImageView.hidden = YES;
        
        
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        UIImage *bgImage = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.backBtn setImage:bgImage forState:UIControlStateNormal];
        [self.backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
        [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        self.backBtn.tintColor = [UIColor whiteColor];
        
        [self.headerView addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.bottom.offset(-5);
            make.height.width.offset(40);
        }];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.headerView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backBtn);
            //        make.centerX.mas_equalTo(self.headerView);
            make.left.mas_equalTo(self.backBtn.mas_right).offset(10);
            make.right.offset(-60);
        }];
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        self.bottomLine = [UIView new];
        self.bottomLine.backgroundColor = RGBColor(200, 200, 200);
        [self.headerView addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(CY_Sigle_Line_Height);
        }];
        
        self.bottomLine.hidden = YES;
    }
    return self;
}

@end
