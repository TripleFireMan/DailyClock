//
//  DKFontCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/14.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKFontCell.h"
#import "DKFontModel.h"
@interface DKFontCell ()

@end

@implementation DKFontCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
        [self addConstrainss];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setupSubviews
{
    [self.contentView addSubview:self.donwloadBtn];
    [self.contentView addSubview:self.progress];
}

- (void) addConstrainss
{
    [self.donwloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.width.offset(60);
        make.height.offset(30);
        make.centerY.offset(0);
    }];
    
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(0);
    }];
}

- (void) setFont:(DKFontModel *)font{
    @weakify(self);
    _font = font;
    
    self.textLabel.text = font.name;
    if ([_font isDownloaded]) { 
        self.textLabel.font=  [UIFont fontWithName:font.fontName size:15];
    }
    else{
        self.textLabel.font = CYPingFangSCRegular(15);
    }
    
    
    _font.block = ^(NSNumber *num) {
        @strongify(self);
        self.progress.progress = [num floatValue];
        if ([num floatValue] == 1) {
            self.progress.hidden = YES;
            self.donwloadBtn.hidden = YES;
            self.textLabel.font = DKFont(15);
        }
        else{
            self.progress.hidden = NO;
        }
    };
    if (_font.isDownloading) {
        self.progress.hidden = NO;
        self.progress.progress = _font.progress;
    }
    else{
        self.progress.hidden = YES;
    }
    
    if ([font isDownloaded]) {
        self.donwloadBtn.hidden = YES;
    }
    else{
        self.donwloadBtn.hidden = NO;
    }
}

- (void) configModel:(id)model
{

}

- (UIButton *) donwloadBtn{
    @weakify(self);
    if (!_donwloadBtn) {
        _donwloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_donwloadBtn setTitle:@"下载" forState:UIControlStateNormal];
        _donwloadBtn.titleLabel.font = DKFont(14);
        _donwloadBtn.backgroundColor = DKIOS13BackgroundColor();
        _donwloadBtn.layer.cornerRadius = 6.f;
        _donwloadBtn.layer.masksToBounds = YES;
        [_donwloadBtn setTitleColor:DKIOS13LabelColor() forState:UIControlStateNormal];
        [[_donwloadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.font downloadFont];
        }];
    }
    return _donwloadBtn;
}

- (UIProgressView *) progress{
    if (!_progress) {
        _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    }
    return _progress;
}
@end
