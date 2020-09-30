//
//
//  Created by 成焱 on 2020/9/19.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKFontSettingViewController.h"
#import "CYRefreshFooter.h"
#import "CYRefreshHeader.h"
#import "DKFontModel.h"


@interface DKFontSettingViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@end

@implementation DKFontSettingViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.page = 1;
    self.title = @"字体设置";
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
    DKFontModel *font = [self.dataSource objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = font.fontName;
    cell.textLabel.font=  [UIFont fontWithName:font.fontName size:15];
    
    if ([font.fontName isEqualToString:[DKApplication cy_shareInstance].fontName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKFontModel *font = [self.dataSource objectAtIndex:indexPath.row];
    [DKApplication cy_shareInstance].fontName = font.fontName;
    [DKApplication cy_shareInstance].boldFontName = font.boldFontName;
    [[DKApplication cy_shareInstance] cy_save];
    [tableView reloadData];
    
    [DKAlert showTitle:@"提示" subTitle:@"字体切换成功，APP重启后生效" clickAction:^(NSInteger idx, NSString * _Nonnull idxTitle) {
        if (idx == DKAlertDone) {
            exit(0);
        }
    } doneTitle:@"确定" array:@[@"取消"]];
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
        DKFontModel *font = [DKFontModel new];
        font.fontName = @"PingFangSC-Regular";
        font.boldFontName = @"PingFangSC-Medium";
        [_dataSource addObject:font];
        
        DKFontModel *happyFont=  [DKFontModel new];
        happyFont.fontName = @"HappyZcool-2016";
        happyFont.boldFontName = @"HappyZcool-2016";
        [_dataSource addObject:happyFont];
    }
    return _dataSource;
}

- (UITableView *) tableView
{
    @weakify(self);
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.mj_header = [CYRefreshHeader headerWithRefreshingBlock:^{
//            @strongify(self);
//            self.page = 1;
//            [self loadData];
//        }];
//        _tableView.mj_footer = [CYRefreshFooter footerWithRefreshingBlock:^{
//            @strongify(self);
//            self.page ++;
//            [self loadData];
//        }];
    }
    return _tableView;
}
#pragma mark -

@end
