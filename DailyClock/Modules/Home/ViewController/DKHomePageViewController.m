//
//
//  Created by 成焱 on 2020/9/3.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKHomePageViewController.h"
#import "DKCreateTargetViewController.h"
#import "DKHomeItemTableViewCell.h"
#import "DKSharePopView.h"

@interface DKHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation DKHomePageViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    @weakify(self);
    DKTargetModel *model = [[[DKTargetManager cy_shareInstance] activeModels] objectAtIndex:indexPath.row];
    static NSString *identifier = @"DKHomeItemTableViewCell";
    DKHomeItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = model;
    cell.clickBlock = ^(id obj) {
        @strongify(self);
        [DKSharePopView showOnView:self.view confirmAction:^{
            [self p_save:model];
        } shareAction:^{
            [self p_save:model];
            [self p_share:model];
        } cancelAction:^{
            
        } targetModel:model signModel:obj];
        
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DKTargetManager cy_shareInstance] activeModels].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DKTargetModel *model = [[[DKTargetManager cy_shareInstance] activeModels]objectAtIndex:indexPath.row];
        model.status = DKTargetStatus_Cancel;
        [[DKTargetManager cy_shareInstance] cy_save];
        [self.tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除目标";
}

//- (UISwipeActionsConfiguration *) tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
//    UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除任务" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        DKTargetModel *model = [[[DKTargetManager cy_shareInstance] activeModels]objectAtIndex:indexPath.row];
//        model.status = DKTargetStatus_Cancel;
//        [[DKTargetManager cy_shareInstance] cy_save];
//        completionHandler(YES);
//        [self.tableView reloadData];
//    }];
//    action.backgroundColor = [UIColor redColor];
//    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[action]];
//    return config;
//}

/// 分享
/// @param model 目标参数
- (void) p_share:(DKTargetModel *)model {
    
}


/// 保存
/// @param model 目标参数
- (void) p_save:(DKTargetModel *)model{
    [[DKTargetManager cy_shareInstance] cy_save];
}


#pragma mark - private
#pragma mark - getter / setter
- (UIButton *) addBtn{
    @weakify(self);
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *addImg = [[UIImage imageNamed:@"tianjia"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_addBtn setImage:addImg forState:UIControlStateNormal];
        _addBtn.tintColor = kThemeGray;
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            DKCreateTargetViewController *vc = [DKCreateTargetViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        
        
    }
    return _addBtn;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[DKHomeItemTableViewCell class] forCellReuseIdentifier:@"DKHomeItemTableViewCell"];
    }
    return _tableView;
}

- (NSMutableArray *) dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark -

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
