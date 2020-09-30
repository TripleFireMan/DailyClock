//
//  DKDailyArticleView.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/22.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDailyArticleView.h"


@interface DKDailyArticleItemView : UIView
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) DKSignModel *model;
@property (nonatomic, strong) DKTargetModel *targetModel;

@end


@implementation DKDailyArticleItemView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.textLabel];
        
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.offset(0);
            make.width.height.offset(40);
            make.bottom.mas_lessThanOrEqualTo(-15);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.left.mas_equalTo(self.iconImage.mas_right).offset(10);
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.nameLabel);
            make.right.offset(-15);
            make.bottom.offset(-15);
        }];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.top.offset(15);
        }];
        
    }
    return self;
}

- (void) setModel:(DKSignModel *)model{
    _model = model;
    self.dateLabel.text = [model.date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.textLabel.text = model.text;
}

- (void) setTargetModel:(DKTargetModel *)targetModel{
    _targetModel = targetModel;
    self.iconImage.image = [UIImage imageNamed:_targetModel.icon?:@""];
    self.nameLabel.text = _targetModel.title;
}
- (UIImageView *) iconImage{
    if (!_iconImage) {
        _iconImage = [UIImageView new];
    }
    return _iconImage;
}
- (UILabel *) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = DKFont(15);
        _nameLabel.textColor = DKIOS13LabelColor();
        _nameLabel.text = @"";
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (UILabel *) dateLabel{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = DKFont(13);
        _dateLabel.textColor = DKIOS13PlaceholderTextColor();
        _dateLabel.text = @"";
    }
    return _dateLabel;
}

- (UILabel *) textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = DKFont(13);
        _textLabel.textColor = DKIOS13SecondLabelColor();
        _textLabel.text = @"";
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

@end



@interface DKDailyArticleView ()

@property (nonatomic, strong) UIImageView *redPoint;
@property (nonatomic, strong) UILabel *articleLabel;
@property (nonatomic, strong) UIStackView *stakeView;
@property (nonatomic, strong) DKTargetModel *model;
@property (nonatomic, strong) UIButton *checkMore;//查看更多
@end

@implementation DKDailyArticleView

- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self){
      [self setupSubviews];
      [self addConstrainss];
  }
  return self;
}

- (void) setupSubviews
{
    [self addSubview:self.redPoint];
    [self addSubview:self.articleLabel];
    [self addSubview:self.stakeView];
    [self addSubview:self.checkMore];
}

- (void) addConstrainss
{
    [self.redPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(0);
        make.width.height.offset(8);
    }];
    
    [self.articleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.redPoint.mas_right).offset(10);
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.redPoint);
    }];
    
    [self.stakeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.articleLabel.mas_bottom).offset(15);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(-10);
    }];
    
    [self.checkMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.centerY.mas_equalTo(self.redPoint);
        make.height.offset(40);
    }];
}

- (void) configModel:(id)model
{
    self.model = model;
    
    if (self.model.rizhi.count == 0) {
        self.articleLabel.text = @"";
        [self.redPoint mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.width.height.offset(0);
        }];
        
        [self.articleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.redPoint);
            make.left.offset(0);
            make.width.height.offset(0);
        }];
        [self.stakeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.articleLabel.mas_bottom).offset(0);
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(0);
        }];
        
    }
    else{
        self.articleLabel.text = @"日志信息";
        [self.redPoint mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.left.offset(0);
            make.width.height.offset(8);
        }];
        
        [self.articleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.redPoint.mas_right).offset(10);
            make.right.offset(-15);
            make.centerY.mas_equalTo(self.redPoint);
        }];
        
        [self.stakeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.articleLabel.mas_bottom).offset(15);
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(-10);
        }];
    }
    
    [[self.stakeView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    NSMutableArray <DKSignModel *>*signs = [[self model] rizhi];
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    signs = [[signs sortedArrayUsingDescriptors:@[des]]mutableCopy];
    [signs enumerateObjectsUsingBlock:^(DKSignModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DKDailyArticleItemView *view =[DKDailyArticleItemView new];
        view.targetModel = self.model;
        view.model = obj;
        [self.stakeView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kScreenSize.width - 30);
        }];
    }];
    
    self.checkMore.hidden = self.model.signModels.count < 3;
    
}

- (UILabel *) articleLabel{
    if (!_articleLabel) {
        _articleLabel = [UILabel new];
        _articleLabel.font = DKFont(18);
        _articleLabel.textColor = DKIOS13LabelColor();
        _articleLabel.text = @"日志信息";
    }
    return _articleLabel;
}

- (UIImageView *) redPoint{
    if (!_redPoint) {
        _redPoint = [UIImageView new];
        _redPoint.backgroundColor = [UIColor redColor];
        _redPoint.layer.cornerRadius = 4.f;
        _redPoint.layer.masksToBounds = YES;
    }
    return _redPoint;
}

- (UIStackView *) stakeView{
    if (!_stakeView) {
        _stakeView = [[UIStackView alloc] init];
        _stakeView.axis = UILayoutConstraintAxisVertical;
        _stakeView.alignment = UIStackViewAlignmentLeading;
        _stakeView.layer.cornerRadius = 12.f;
        _stakeView.layer.masksToBounds = YES;
        _stakeView.backgroundColor = DKIOS13ContainerColor();
    }
    return _stakeView;
}

- (UIButton *) checkMore{
    @weakify(self);
    if (!_checkMore) {
        _checkMore = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkMore setTitle:@"查看更多" forState:UIControlStateNormal];
        _checkMore.titleLabel.font = DKFont(14);
        [_checkMore setTitleColor:DKIOS13LabelColor() forState:UIControlStateNormal];
//        _checkMore.backgroundColor = [UIColor redColor];
        [[_checkMore rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.checkMoreAction ? self.checkMoreAction() : nil;
        }];
    }
    return _checkMore;
}
@end
