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

@interface DKMineViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 30, 0, 30);
        [_collectionView cy_adjustForIOS13];
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
