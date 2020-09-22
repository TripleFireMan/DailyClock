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
    [[[XCUIApplication alloc] init].tables/*@START_MENU_TOKEN@*/.otherElements[@"homeItemCell"]/*[[".cells.otherElements[@\"homeItemCell\"]",".otherElements[@\"homeItemCell\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
            
            
    
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
