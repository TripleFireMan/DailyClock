//
//
//  Created by 成焱 on 2020/9/12.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKMineViewController.h"
#import "DKUserCenterHeader.h"
#import "DKSettingViewController.h"

@interface DKMineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIScrollView      *scroll;
@property (nonatomic, strong) UIView            *topView;
@property (nonatomic, strong) UICollectionView  *itemView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DKUserCenterHeader *tableHeader;

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
    
}

- (void) setupSubView
{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeader;
    [self.headerView addSubview:self.settingBtn];
}

- (void) addConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView cy_adjustForIOS13];
    }
    return _tableView;
}

- (DKUserCenterHeader *) tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[DKUserCenterHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 180)];
    }
    return _tableHeader;
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
