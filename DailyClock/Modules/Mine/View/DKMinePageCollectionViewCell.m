//
//  DKMinePageCollectionViewCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/17.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKMinePageCollectionViewCell.h"
@interface DKMinePageCollectionViewCell ()

@property (nonatomic, strong) UIImageView   *img;
@property (nonatomic, strong) UILabel       *label;

@end
@implementation DKMinePageCollectionViewCell
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [UIImageView new];
        [self.contentView addSubview:self.img];
        
        self.label = [UILabel new];
        self.label.font = DKFont(14);
        [self.contentView addSubview:self.label];
        
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.centerX.offset(0);
            make.width.height.offset(40.f);
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.img.mas_bottom).offset(10);
            make.centerX.offset(0);
        }];
        
        self.contentView.backgroundColor = DKIOS13BackgroundColor();
        self.label.textColor = DKIOS13LabelColor();
        
        self.contentView.layer.cornerRadius = 12.f;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

- (void) setModel:(DKMineItemModel *)model{
    _model = model;
    self.img.image = _model.img;
    self.label.text = _model.title;
    
}
@end
