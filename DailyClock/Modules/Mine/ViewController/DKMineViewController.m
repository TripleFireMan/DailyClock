//
//
//  Created by 成焱 on 2020/9/12.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKMineViewController.h"
#import "DKUserCenterHeader.h"
#import "DKSettingViewController.h"
#import "DKMinePageCollectionViewCell.h"
#import "DKMineItemModel.h"
#import "DKUserCenterFooter.h"
#import "DKPausedTargetViewController.h"
#import "DKDataResumeViewController.h"
#import "DKFeedBackViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "DKVersionHistoryViewController.h"

@interface DKMineViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) DKUserCenterHeader *tableHeader;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <DKMineItemModel *>*dataSource;
@end

@implementation DKMineViewController

#pragma mark - def

#pragma mark - override
- (id) init{
    self  = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"个人中心";
    self.shouldShowBackBtn = NO;
    
    [self.collectionView reloadData];

}

- (void) setupSubView
{
    [self.view addSubview:self.collectionView];
    [self.headerView addSubview:self.settingBtn];
}

- (void) addConstraints
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(CY_Height_NavBar, 0, CY_Height_TabBar, 0));
    }];
    
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.bottom.offset(0);
        make.width.height.offset(44);
    }];
    
    
}

#pragma mark - api

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol

#pragma mark - private
#pragma mark - getter / setter

#pragma mark -


- (UICollectionView *) collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        CGFloat headerWidth ,footerWidth = 25.f;
        CGFloat gap = 15.f;
        NSInteger count = 3;
        CGFloat itemWidth = (kScreenSize.width - 60.f- gap * count) / count;
        flowLayout.itemSize = CGSizeMake(itemWidth, 100.f);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        if (@available(iOS 13.0, *)) {
            _collectionView.backgroundColor = [UIColor systemBackgroundColor];
        } else {
            _collectionView.backgroundColor = [UIColor whiteColor];
        }
        _collectionView.contentInset = UIEdgeInsetsMake(0, 30, 0, 30);
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[DKUserCenterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DKUserCenterHeader"];
        [_collectionView registerClass:[DKUserCenterFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DKUserCenterFooter"];
        [_collectionView registerClass:[DKMinePageCollectionViewCell class] forCellWithReuseIdentifier:@"DKMinePageCollectionViewCell"];
    }
    return _collectionView;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DKUserCenterHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DKUserCenterHeader" forIndexPath:indexPath];
        if (!header) {
            header = self.tableHeader;
        }
        return header;
    }
    else{
        DKUserCenterFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DKUserCenterFooter" forIndexPath:indexPath];
        if (!footer) {
            footer = [DKUserCenterFooter new];
        }
        return footer;
    }
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 180);
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 50);
}



- (__kindof UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DKMineItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
    DKMinePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DKMinePageCollectionViewCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DKMineItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if ([model.title isEqualToString:@"已暂停目标"]) {
        DKPausedTargetViewController *vc = [DKPausedTargetViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1){
        DKDataResumeViewController *vc = [DKDataResumeViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2){
        DKFeedBackViewController *feedBack = [DKFeedBackViewController new];
        [self.navigationController pushViewController:feedBack animated:YES];
    }
    else if (indexPath.row == 3){
        [self p_sendEmail];
    }
    else if (indexPath.row == 4){
        DKVersionHistoryViewController *vc=  [DKVersionHistoryViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 5){
        [self p_share];
    }
}
- (void) p_sendEmail{
    MFMailComposeViewController *mailVC = [MFMailComposeViewController new];
    if (!mailVC) {
        // 在设备还没有添加邮件账户的时候，为空
        NSLog(@"暂未设置邮箱账户，请先到系统设置添加账户");
        return;
    }
    NSString *body = [NSString stringWithFormat:@"\n\n\n\n\nAPP:极简打卡\n版本:%@\n设备机型:%@\n系统版本:%@",APPVersion,[[UIDevice currentDevice]machineModelName],[UIDevice currentDevice].systemVersion];
    //代理 MFMailComposeViewControllerDelegate
    mailVC.mailComposeDelegate = self;
    [mailVC setMessageBody:body isHTML:NO];
    //邮件主题
    [mailVC setSubject:@"联系作者"];
    //收件人
    [mailVC setToRecipients:@[@"ab364743113@126.com"]];
    
    [self presentViewController:mailVC animated:YES completion:nil];
}

- (void) p_share {
    UIImage* image = [UIImage imageNamed:@"dk_icon"];

    NSString *text = @"一款简洁、萌萌哒的打卡小软件，赶紧下载体验下吧~";

    NSURL *urlToShare = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id1531050825?l=zh&ls=1&mt=8"]];

    NSArray *activityItems = @[image,text,urlToShare];

    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];

    [self presentViewController:avc animated:TRUE completion:nil];

    // 选中分享类型

    [avc setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){

    // 显示选中的分享类型

    NSLog(@"act type %@",activityType);

    if (completed) {

    NSLog(@"ok");

    }else {

    NSLog(@"no ok");

    }

    }];

    UIPopoverPresentationController *popover = avc.popoverPresentationController;

    if (popover) {

    popover.sourceView = self.view;

    popover.sourceRect = self.view.bounds;

    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;

    }
}

// 实现代理方法
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // MFMailComposeResultCancelled
    // MFMailComposeResultSaved
    // MFMailComposeResultSent
    // MFMailComposeResultFailed
  
    if (result == MFMailComposeResultSent) {
        [XHToast showBottomWithText:@"发送成功"];
    } else if (result == MFMailComposeResultFailed) {
        [XHToast showBottomWithText:@"发送失败"];
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (DKUserCenterHeader *) tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[DKUserCenterHeader alloc] init];
    }
    return _tableHeader;
}

- (NSMutableArray <DKMineItemModel *> *) dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSArray *imgs = @[@"box",@"download",@"faq",@"faq2",@"email",@"feedback"];
        NSArray *titles = @[@"已暂停目标",@"数据备份",@"问题反馈",@"联系作者",@"版本记录",@"分享"];
        for (int i = 0; i <imgs.count ; i++) {
            DKMineItemModel *model = [DKMineItemModel new];
            model.img = [UIImage imageNamed:imgs[i]];
            model.title = titles[i];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (UIButton *)settingBtn{
    @weakify(self);
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        [_settingBtn setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
        [[_settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            DKSettingViewController *setting = [[DKSettingViewController alloc] init];
            [self.navigationController pushViewController:setting animated:YES];
        }];
    }
    return _settingBtn;
}

@end
