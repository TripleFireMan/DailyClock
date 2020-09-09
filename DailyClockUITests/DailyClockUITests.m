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
    // UI tests must launch the application that they test.
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [Snapshot snapshot:@"0.png" timeWaitingForIdle:10];
    [app.buttons[@"tianjia"] tap];
    [Snapshot snapshot:@"1.png" timeWaitingForIdle:10];
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"\u65e9\u8d77"]/*[[".cells.staticTexts[@\"\\u65e9\\u8d77\"]",".staticTexts[@\"\\u65e9\\u8d77\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [Snapshot snapshot:@"2.png" timeWaitingForIdle:10];
    [app.buttons[@"\u4fdd\u5b58"] tap];
    [Snapshot snapshot:@"3.png" timeWaitingForIdle:10];
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
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
