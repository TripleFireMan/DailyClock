//
//
//  Created by 成焱 on 2020/10/29.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKTargetListViewController.h"
#import "CYRefreshFooter.h"
#import "CYRefreshHeader.h"
#import "DKCurrentTableViewCell.h"
#import "DKTargetDetailViewController.h"
#import "DKCreateTargetViewController.h"

@interface DKTargetListViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation DKTargetListViewController

#pragma mark - def

#pragma mark - override

- (id) init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.page = 1;
    self.titleLabel.text = @"目标";
    self.shouldShowBackBtn = NO;
    @weakify(self);
    [RACObserve([DKApplication cy_shareInstance], fontName) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
        self.titleLabel.font = [UIFont fontWithName:[DKApplication cy_shareInstance].boldFontName size:18.f];
    }];

}

- (void) loadData {
    @weakify(self);
    if ([DKTargetManager cy_shareInstance].activeModels.count == 0) {
        [self.tableView cy_showEmptyImage:@"BeginTargetTip" text:@"你还没有创建目标，点击右上角开始吧~" topMargin:200 clickRefresh:^{
            @strongify(self);
            [self loadData];
        }];
    }
    else{
        [self.tableView cy_hideAll];
    }
    [self.tableView reloadData];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self loadData];
}

- (void) setupSubView
{
    [self.headerView addSubview:self.addBtn];
    [self.view addSubview:self.tableView];
}

- (void) addConstraints
{
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.offset(0);
        make.width.height.offset(44);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.offset(0);
        make.bottom.offset(-CY_Height_TabBar);
    }];
}

#pragma mark - api
#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKTargetModel *model = [[[DKTargetManager cy_shareInstance] activeModels] objectAtIndex:indexPath.row];
    DKCurrentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DKCurrentTableViewCell"];
    [cell configModel:model];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DKTargetManager cy_shareInstance] activeModels] count];;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    vibrate();
    DKTargetModel *model = [[[DKTargetManager cy_shareInstance] activeModels] objectAtIndex:indexPath.row];
    DKTargetDetailViewController *detail = [DKTargetDetailViewController new];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
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
- (NSMutableArray *) dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

- (UITableView *) tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DKCurrentTableViewCell class] forCellReuseIdentifier:@"DKCurrentTableViewCell"];
    }
    return _tableView;
}
#pragma mark -
- (UIButton *) addBtn{
    @weakify(self);
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *addImg = [[UIImage imageNamed:@"NavView_Add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_addBtn setImage:addImg forState:UIControlStateNormal];
        _addBtn.tintColor = DKIOS13LabelColor();

        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            vibrate();
            DKCreateTargetViewController *vc = [DKCreateTargetViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        
        
    }
    return _addBtn;
}
@end
