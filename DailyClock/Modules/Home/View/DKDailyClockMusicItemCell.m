//
//  DKDailyClockMusicItemCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/11.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDailyClockMusicItemCell.h"
#import "DKPlayMusicModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>

@interface DKDailyClockMusicItemCell ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) UIImageView *musicIcon;
@property (nonatomic, strong) UILabel *musicName;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, strong) DKPlayMusicModel *musicModel;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation DKDailyClockMusicItemCell

- (void) dealloc{
    [self stop];
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
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
    [self.contentView addSubview:self.musicIcon];
    [self.contentView addSubview:self.musicName];
}

- (void) addConstrainss
{
    [self.musicIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(20);
        make.centerY.offset(0);
        make.width.height.offset(20);
        make.bottom.offset(-15);
    }];
    
    [self.musicName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.musicIcon.mas_right).offset(10);
        make.centerY.offset(0);
    }];
}

- (void) configModel:(id)model
{
    self.musicModel = model;
    self.musicName.text = self.musicModel.alert;
    if (self.musicModel.isPlaying) {
//        [self start:NO];
    }
    else{
        [self stop];
    }
}

- (void) setReminder:(DKReminder *)reminder{
    _reminder = reminder;
    if ([self.musicName.text isEqualToString:reminder.alert]) {
        self.musicIcon.highlighted = YES;
    }
    else{
        self.musicIcon.highlighted = NO;
    }
}

- (UILabel *) musicName{
    if (!_musicName) {
        _musicName = [UILabel new];
        _musicName.font = DKFont(14);
        _musicName.textColor = DKIOS13LabelColor();
        _musicName.text = @"";
    }
    return _musicName;
}

- (UIImageView *) musicIcon{
    if (!_musicIcon) {
        _musicIcon = [UIImageView new];
        _musicIcon.image = [UIImage imageNamed:@"quaver-0"];
        _musicIcon.highlightedImage = [UIImage imageNamed:@"quaver-1"];
    }
    return _musicIcon;
}

- (void) rotate{
    self.startAngle += M_PI / 120.f;
    self.musicIcon.transform = CGAffineTransformMakeRotation(self.startAngle);
    if (self.musicModel.isPlaying == NO) {
        [self stop];
    }
}

- (void) start{
    [self start:YES];
}

- (void) start:(BOOL)WithMusic{
    [self.timer invalidate];
    self.timer = nil;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    if (WithMusic) {
        NSURL *system_sound_url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.musicModel.alert ofType:@"caf"]];
        NSError *error = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:system_sound_url error:&error];
        [self.player prepareToPlay];
        self.player.delegate = self;
        [self.player play];
    }
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self stop];
}



- (void) stop{
    self.startAngle = 0;
    self.musicModel.isPlaying = NO;
    [_timer invalidate];
    _timer = nil;
    self.musicIcon.transform = CGAffineTransformIdentity;
    
    
    [self.player stop];
    self.player = nil;
}



- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1/60.f target:[YYWeakProxy proxyWithTarget:self] selector:@selector(rotate) userInfo:nil repeats:YES];
    }
    return _timer;
}
@end

