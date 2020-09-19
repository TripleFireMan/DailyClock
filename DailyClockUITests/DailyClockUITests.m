//
//  DailyClockUITests.m
//  DailyClockUITests
//
//  Created by 成焱 on 2020/9/1.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DailyClockUITests-Swift.h"
@interface DailyClockUITests : XCTestCase

@end

@implementation DailyClockUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [Snapshot setupSnapshot:app waitForAnimations:YES];
    [app launch];
    
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"NavView Add"] tap];
    [Snapshot snapshot:@"1" timeWaitingForIdle:10];
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"\u65e9\u8d77"]/*[[".cells.staticTexts[@\"\\u65e9\\u8d77\"]",".staticTexts[@\"\\u65e9\\u8d77\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [Snapshot snapshot:@"2" timeWaitingForIdle:10];
    [app.buttons[@"\u4fdd\u5b58"] tap];
    [app.tabBars.buttons[@"\u6211\u7684"] tap];
    [Snapshot snapshot:@"3" timeWaitingForIdle:10];
    XCUIElementQuery *cellsQuery = app.collectionViews.cells;
    [[cellsQuery.otherElements containingType:XCUIElementTypeImage identifier:@"download"].element tap];
    [Snapshot snapshot:@"4" timeWaitingForIdle:10];
    XCUIElement *backButton = app.buttons[@"back"];
    [backButton tap];
    [[cellsQuery.otherElements containingType:XCUIElementTypeImage identifier:@"faq"].element tap];
    [Snapshot snapshot:@"5" timeWaitingForIdle:10];
    [backButton tap];
    
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[XCTOSSignpostMetric.applicationLaunchMetric] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
