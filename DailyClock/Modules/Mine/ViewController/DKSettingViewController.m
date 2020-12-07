//
//
//  Created by 成焱 on 2020/9/14.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKSettingViewController.h"
#import "CYBaseNavigationBar.h"
#import "DKAboutUsViewController.h"
#import "DKFontSettingViewController.h"
#import "DKSettingItem.h"

@interface DKSettingViewController ()<UITableViewDelegate, UITableViewDataSource,UIFontPickerViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DKSettingViewController

#pragma mark - def

#pragma mark - override

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"设置";
    self.shouldShowBackBtn = YES;
    @weakify(self);
    [RACObserve([DKApplication cy_shareInstance], fontName) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
        self.titleLabel.font = [UIFont fontWithName:[DKApplication cy_shareInstance].boldFontName size:18.f];
    }];
}

- (void) setupSubView
{
    [self.view addSubview:self.tableView];
}

- (void) addConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.offset(0);
        make.bottom.offset(0);
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
//    NSArray *titles = [[DKSettingItem allSettings] valueForKeyPath:@"title"];
    DKSettingItem *item = [[[DKApplication cy_shareInstance] settingItems] objectAtIndex:indexPath.row];
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = item.title;
    cell.textLabel.font = DKFont(15);
    if ([item hasArrow]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if ([item hasSwitch]) {
        UISwitch *switchView = [[UISwitch alloc] init];
        switchView.on = item.isOn;
        [[switchView rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
            UISwitch *innerSwitch = (UISwitch *) x;
            item.isOn = innerSwitch.isOn;
            [[DKApplication cy_shareInstance] cy_save];
            [MobClick event:@"mine_setting_switch_on" attributes:@{@"name":item.title,
                                                                   @"On":@(item.isOn)
            }];
        }];
        switchView.onTintColor = kMainColor;
        cell.accessoryView = switchView;
    }
    else{
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DKApplication cy_shareInstance] settingItems].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    vibrate();
    
    DKSettingItem *item = [[[DKApplication cy_shareInstance] settingItems] objectAtIndex:indexPath.row];
    [MobClick event:@"mine_setting_cell" attributes:@{@"title":item.title}];
    switch (item.settingType) {
        case DKSettingItem_AboutUs:
        {
            DKAboutUsViewController *vc = [DKAboutUsViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DKSettingItem_UserProtocol:
        {
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"userregiest" ofType:@"html"]];
            CYH5ViewController *h5 = [[CYH5ViewController alloc] initWithURL:url];
            [self.navigationController pushViewController:h5 animated:YES];
        }
            break;
        case DKSettingItem_PrivateProtocol:
        {
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"private" ofType:@"html"]];
            CYH5ViewController *h5 = [[CYH5ViewController alloc] initWithURL:url];
            [self.navigationController pushViewController:h5 animated:YES];
        }
            break;
        case DKSettingItem_RecommendUS:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1531050825&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
            break;
        case DKSettingItem_FontSetting:
        {
            DKFontSettingViewController *vc = [DKFontSettingViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DKSettingItem_Vibrate:
        {
            
        }
            break;
        case DKSettingItem_MusicForClock:
        {
            
        }
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void) fontPickerViewControllerDidCancel:(UIFontPickerViewController *)viewController API_AVAILABLE(ios(13.0)){
    
}

- (void) fontPickerViewControllerDidPickFont:(UIFontPickerViewController *)viewController
API_AVAILABLE(ios(13.0)){
    
    UIFontDescriptor *font = viewController.selectedFontDescriptor;
    [DKApplication cy_shareInstance].fontName = font.fontAttributes[NSFontAttributeName];
    [DKApplication cy_shareInstance].boldFontName = font.fontAttributes[NSFontAttributeName];
    [[DKApplication cy_shareInstance] cy_save];

    [DKAlert showTitle:@"提示" subTitle:@"字体切换成功，APP重启后生效" clickAction:^(NSInteger idx, NSString * _Nonnull idxTitle) {
        if (idx == DKAlertDone) {
            exit(0);
        }
    } doneTitle:@"确定" array:@[@"取消"]];

}


#pragma mark - private
#pragma mark - getter / setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 58;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    return _tableView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

//- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view=  [[UIView alloc] init];
//    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    logoutBtn.backgroundColor = kMainColor;
//    logoutBtn.layer.cornerRadius = 20.f;
//    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    logoutBtn.titleLabel.font = DKFont(15);
//    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//    [view addSubview:logoutBtn];
//    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(30);
//        make.right.offset(-30);
//        make.height.offset(40);
//        make.center.offset(0);
//    }];
//
//    return view;
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 200;
//}

#pragma mark -

@end
