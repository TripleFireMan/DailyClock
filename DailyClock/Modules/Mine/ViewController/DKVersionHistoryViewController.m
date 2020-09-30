//
//
//  Created by 成焱 on 2020/9/19.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKVersionHistoryViewController.h"
#import "CYRefreshFooter.h"
#import "CYRefreshHeader.h"
#import "DKVersionHistoryCell.h"
#import "DKVersionModel.h"

@interface DKVersionHistoryViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@end

@implementation DKVersionHistoryViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"历史版本";
    [self loadData];
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
    @weakify(self);
    [HttpTool GET:VersionHistory parameters:nil HUD:YES success:^(id responseObject) {
        NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
        if (status==0) {
            NSArray *versions = [NSArray modelArrayWithClass:[DKVersionModel class] json:[responseObject objectForKey:@"data"]];
            if (versions.count != 0) {
                [self.dataSource addObjectsFromArray:versions];
                [self.tableView reloadData];
            }
            else{
                [self.tableView cy_showEmptyImage:@"BeginTargetTip" text:@"空空思密达"  topMargin: 200 clickRefresh:^{
                    @strongify(self);
                    [self loadData];
                }  ] ;
            }
        }
        else{
            [self.tableView cy_showEmptyImage:@"BeginTargetTip" text:@"空空思密达"  topMargin: 200 clickRefresh:^{
                @strongify(self);
                [self loadData];
            }  ] ;
        }
    } failure:^(NSError *error) {
        [self.tableView cy_showEmptyImage:@"BeginTargetTip" text:@"空空思密达"  topMargin: 200 clickRefresh:^{
            @strongify(self);
            [self loadData];
        }  ] ;
    }];
}
#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKVersionModel *model = [self.dataSource objectAtIndex:indexPath.row];
    DKVersionHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DKVersionHistoryCell"];
    [cell configModel:model];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        [_tableView registerClass:[DKVersionHistoryCell class] forCellReuseIdentifier:@"DKVersionHistoryCell"];
        
    }
    return _tableView;
}
#pragma mark -

@end
