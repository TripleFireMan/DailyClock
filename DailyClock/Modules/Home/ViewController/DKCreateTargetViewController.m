//
//
//  Created by 成焱 on 2020/9/3.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKCreateTargetViewController.h"
#import "DKTargetModel.h"
#import "DKCreateTargetCell.h"
#import "DKCustomeTargetCell.h"
#import "DKTargetSettingViewController.h"

@interface DKCreateTargetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <DKTargetModel *>*datasource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DKCreateTargetViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"添加目标";
    self.shouldShowBackBtn = YES;
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

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol

#pragma mark - tableViewDelegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DKTargetModel *model  = [self.datasource objectAtIndex:indexPath.row];
    if (model.ID ==0) {
        static NSString *identifier = @"DKCustomeTargetCell";
        DKCustomeTargetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell configModel:model];
        return cell;
    }
    else{
        static NSString *identifier = @"DKCreateTargetCell";
        DKCreateTargetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell configModel:model];
        return cell;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    vibrate();
    DKTargetModel *model = [self.datasource objectAtIndex:indexPath.row];
    DKTargetSettingViewController *settingVC = [DKTargetSettingViewController initWithTargetType:DKTargetSettingType_Insert model:model];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}


#pragma mark - private
#pragma mark - getter / setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[DKCreateTargetCell class] forCellReuseIdentifier:@"DKCreateTargetCell"];
        [_tableView registerClass:[DKCustomeTargetCell class] forCellReuseIdentifier:@"DKCustomeTargetCell"];
    }
    return _tableView;
}

#pragma mark -
- (NSMutableArray <DKTargetModel *> *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"targets" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
        NSDictionary *datamodels = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *models = [NSArray modelArrayWithClass:[DKTargetModel class] json:datamodels[@"data"]];
        [_datasource addObjectsFromArray:models];
    }
    return _datasource;
}

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end
