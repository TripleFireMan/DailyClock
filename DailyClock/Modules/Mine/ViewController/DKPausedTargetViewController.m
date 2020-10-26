//
//
//  Created by 成焱 on 2020/9/18.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKPausedTargetViewController.h"
#import "CYRefreshFooter.h"
#import "CYRefreshHeader.h"
#import "DKPausedTargetCell.h"
#import "DKTargetSettingViewController.h"
#import "DKTargetDetailViewController.h"

@interface DKPausedTargetViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@end

@implementation DKPausedTargetViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.page = 1;
    self.title = @"已暂停目标";
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    if ([[DKTargetManager cy_shareInstance] cancelModels].count == 0) {
        [self.tableView cy_showEmptyImage:@"BeginTargetTip" text:@"空空如野~~~" topMargin:200 clickRefresh:^{
        }];
    }
    else{
        [self.tableView cy_hideAll];
    }
}

- (void) setupSubView
{
    [self.view addSubview:self.tableView];
}

- (void) addConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
}

#pragma mark - api
- (void) loadData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
}
#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKTargetModel *model = [[[DKTargetManager cy_shareInstance] cancelModels] objectAtIndex:indexPath.row];
    DKPausedTargetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DKPausedTargetCell"];
    [cell configModel:model];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DKTargetManager cy_shareInstance] cancelModels].count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    vibrate();
    DKTargetModel *model = [[[DKTargetManager cy_shareInstance] cancelModels] objectAtIndex:indexPath.row];
    DKTargetDetailViewController *settingVC = [[DKTargetDetailViewController alloc] init];
    settingVC.model = model;
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10.f;
}
#pragma mark - private
#pragma mark - getter / setter
- (UITableView *) tableView
{
//    @weakify(self);
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        if (@available(iOS 11, *)) {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DKPausedTargetCell class] forCellReuseIdentifier:@"DKPausedTargetCell"];
    }
    return _tableView;
}
#pragma mark -

@end
