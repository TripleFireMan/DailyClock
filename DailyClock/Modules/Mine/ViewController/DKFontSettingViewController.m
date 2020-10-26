//
//
//  Created by 成焱 on 2020/9/19.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKFontSettingViewController.h"
#import "CYRefreshFooter.h"
#import "CYRefreshHeader.h"
#import "DKFontModel.h"
#import "DKFontCell.h"
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
//    @weakify(self);
    [HttpTool GET:kDailyClockFont parameters:nil HUD:YES success:^(id responseObject) {
        NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
        if (status==0) {
            NSArray *versions = [NSArray modelArrayWithClass:[DKFontModel class] json:[responseObject objectForKey:@"data"]];
            if (versions.count != 0) {
                [self.dataSource addObjectsFromArray:versions];
                [self.tableView reloadData];
            }
//                else{
//                    [self.tableView cy_showEmptyImage:@"BeginTargetTip" text:@"空空思密达"  topMargin: 200 clickRefresh:^{
//                        @strongify(self);
//                        [self loadData];
//                    }  ] ;
//                }
        }
        else{
//                [self.tableView cy_showEmptyImage:@"BeginTargetTip" text:@"空空思密达"  topMargin: 200 clickRefresh:^{
//                    @strongify(self);
//                    [self loadData];
//                }  ] ;
        }
    } failure:^(NSError *error) {
//            [self.tableView cy_showEmptyImage:@"BeginTargetTip" text:@"空空思密达"  topMargin: 200 clickRefresh:^{
//                @strongify(self);
//                [self loadData];
//            }  ] ;
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
    DKFontModel *font = [self.dataSource objectAtIndex:indexPath.row];
    DKFontCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DKFontCell"];
    if (!cell) {
        cell = [[DKFontCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DKFontCell"];
    }
    
    cell.font = font;
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
    vibrate();
    DKFontModel *font = [self.dataSource objectAtIndex:indexPath.row];
    if ([font isDownloading]) {
        [XHToast showBottomWithText:@"字体正在下载"];
        return;
    }
    if (![font isDownloaded]) {
        [XHToast showBottomWithText:@"字体还未下载，请先下载安装"];
        return;
    }
    [DKApplication cy_shareInstance].boldFontName = font.boldFontName;
    [DKApplication cy_shareInstance].fontName = font.fontName;
    
    [[DKApplication cy_shareInstance] cy_save];
    [tableView reloadData];
    self.titleLabel.font = [UIFont fontWithName:[DKApplication cy_shareInstance].boldFontName size:18.f];
    
    [XHToast showBottomWithText:@"字体切换成功"];
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
        font.name = @"系统字体";
        font.fontName = @"PingFangSC-Regular";
        font.boldFontName = @"PingFangSC-Medium";
        [_dataSource addObject:font];
        
        DKFontModel *happyFont=  [DKFontModel new];
        happyFont.name =@"2016快乐体";
        happyFont.fontName = @"HappyZcool-2016";
        happyFont.boldFontName = @"HappyZcool-2016";
        [_dataSource addObject:happyFont];
        
//        DKFontModel *songT = [DKFontModel new];
//        songT.fontName = @"KaiTi_GB2312";
//        songT.name = @"楷体GB2312";
//        songT.boldFontName = @"KaiTi_GB2312";
//        songT.url = @"http://chengyan.shop/static/fonts/%E6%A5%B7%E4%BD%93_GB2312.ttf";
//        [_dataSource addObject:songT];

//        DKFontModel *DFWaWaSCW5 = [DKFontModel new];
//        DFWaWaSCW5.name = @"娃娃体";
//        DFWaWaSCW5.fontName = @"DFWaWaSC-W5";
//        DFWaWaSCW5.boldFontName = @"DFWaWaSC-W5";
//        [_dataSource addObject:DFWaWaSCW5];
//
//        DKFontModel *HanziPenSCW3 = [DKFontModel new];
//        HanziPenSCW3.name = @"翩翩体";
//        HanziPenSCW3.fontName = @"HanziPenSC-W3";
//        HanziPenSCW3.boldFontName = @"HanziPenSC-W3";
//        [_dataSource addObject:HanziPenSCW3];
//
//        DKFontModel *STYuanti_SC_Regular = [DKFontModel new];
//        STYuanti_SC_Regular.name = @"圆体";
//        STYuanti_SC_Regular.fontName = @"STYuanti-SC-Regular";
//        STYuanti_SC_Regular.boldFontName = @"STYuanti-SC-Regular";
//        [_dataSource addObject:STYuanti_SC_Regular];
//
//        DKFontModel *YuppyTC_Regular = [DKFontModel new];
//        YuppyTC_Regular.name = @"雅痞-简";
//        YuppyTC_Regular.fontName = @"YuppySC-Regular";
//        YuppyTC_Regular.boldFontName = @"YuppySC-Regular";
//        [_dataSource addObject:YuppyTC_Regular];
//
//
//        DKFontModel *WeibeiSC_Bold = [DKFontModel new];
//        WeibeiSC_Bold.name = @"魏碑-简";
//        WeibeiSC_Bold.fontName = @"WeibeiSC-Bold";
//        WeibeiSC_Bold.boldFontName = @"WeibeiSC-Bold";
//        [_dataSource addObject:WeibeiSC_Bold];
//
//
//
//
//
    
    }
    return _dataSource;
}



- (UITableView *) tableView
{
//    @weakify(self);
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DKFontCell class] forCellReuseIdentifier:@"DKFontCell"];
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
