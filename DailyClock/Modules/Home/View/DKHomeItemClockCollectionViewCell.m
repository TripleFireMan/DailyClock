//
//  DKHomeItemClockCollectionViewCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/8.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKHomeItemClockCollectionViewCell.h"

@interface DKHomeItemClockCollectionViewCell()

@property (nonatomic, strong) UIView *container;

@property (nonatomic, strong) UILabel *textLabel;

/// 已签到
@property (nonatomic, strong) UIImageView *signImageview;

/// 提示签到
@property (nonatomic, strong) UIImageView *dakaImageView;


@end
@implementation DKHomeItemClockCollectionViewCell



- (void) setWeekModel:(DKTargetPinCiWeekModel *)weekModel{
    _weekModel = weekModel;
    
    
    NSDate *today = [NSDate date];
    if ([self isSameDay:today date2:_weekModel.date]) {
        self.textLabel.text = @"打卡";
        self.textLabel.font = DKFont(14);
        
        self.dakaImageView.hidden = YES;
//        self.dakaImageView.highlighted = NO;
        self.container.backgroundColor = [UIColor redColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.container.layer.borderColor = [UIColor clearColor].CGColor;
        [self.model.signModels enumerateObjectsUsingBlock:^(DKSignModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.date isToday]) {
//                self.dakaImageView.hidden = YES;
                self.textLabel.text = @"今天";
                self.container.backgroundColor = kMainColor;
                self.textLabel.font = DKFont(11);
                self.textLabel.textColor = [UIColor blackColor];
                self.container.layer.borderColor = [UIColor clearColor].CGColor;
//                self.dakaImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                *stop = YES;
            }
        }];
        
    }
    else{
        self.textLabel.font = DKFont(11);
        BOOL isSigned = [self isSigned:_weekModel];
        if (isSigned) {
            self.container.backgroundColor = kMainColor;
            self.textLabel.textColor = [UIColor blackColor];
            self.container.layer.borderColor = [UIColor clearColor].CGColor;
        }
        else{
            self.container.backgroundColor = [UIColor lightTextColor];
            self.textLabel.textColor = [UIColor blackColor];
            self.container.layer.borderColor = [UIColor clearColor].CGColor;
        }
        self.textLabel.text = _weekModel.weekName;
        self.dakaImageView.hidden = YES;
    }
}

- (BOOL) isSigned:(DKTargetPinCiWeekModel *)weekModel {
    __block BOOL isSigned = NO;
    
    [[self.model signModels] enumerateObjectsUsingBlock:^(DKSignModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isSameDay:obj.date date2:weekModel.date]) {
            isSigned = YES;
        }
    }];
    
    return isSigned;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    self.container.layer.cornerRadius = frame.size.width / 2.f;
    self.container.layer.masksToBounds = YES;
}
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.container];
        [self.container addSubview:self.textLabel];
        [self.container addSubview:self.dakaImageView];
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.mas_equalTo(self.container.mas_width);
            make.centerY.offset(0);
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
        
        [self.dakaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.mas_equalTo(self.container.mas_width);
            make.centerY.offset(0);
        }];
    }
    return self;
}


- (UIView *) container{
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = [UIColor lightTextColor];
        _container.layer.borderWidth = 1;
        _container.layer.borderColor = [UIColor blackColor].CGColor;
        _container.layer.cornerRadius = 8.f;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UILabel *) textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = DKFont(11);
        _textLabel.textColor = [UIColor blackColor];
    }
    return _textLabel;
}


- (UIImageView *) signImageview{
    if (!_signImageview) {
        _signImageview = [UIImageView new];
        _signImageview.image = [UIImage imageNamed:@""];
    }
    return _signImageview;
}

- (UIImageView *) dakaImageView{
    if (!_dakaImageView) {
        _dakaImageView = [UIImageView new];
//        _dakaImageView.backgroundColor = [UIColor redColor];
        _dakaImageView.image = [[UIImage imageNamed:@"daka"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _dakaImageView.highlightedImage = [[UIImage imageNamed:@"wanc"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _dakaImageView.tintColor = kMainColor;
    }
    return _dakaImageView;
}

- (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}

@end


@interface NSMutableArray  (aa)


    
@end

@implementation NSMutableArray (aa)

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(removeObject:) with:@selector(ddremoveObject:)];
        [self swizzleInstanceMethod:@selector(removeAllObjects) with:@selector(ddremoveAllObjects)];
    });
}

- (void)ddremoveObject:(id) obj{
    [self ddremoveObject:obj];
    if ([obj isKindOfClass:[DKSignModel class]]) {
        
    }
    
    
}

- (void)ddremoveAllObjects{
    [self removeAllObjects];
    
}

@end
