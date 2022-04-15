//
//  XLLMutableSetTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/6.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLMutableSetTest : XCTestCase
{
    NSMutableSet *setM;
}

@end

@implementation XLLMutableSetTest

- (void)setUp {
    [super setUp];
    
    setM = [NSMutableSet set];
}

// 增
- (void)testAddObject {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([setM addObject:nil]);
#pragma clang diagnostic pop
}

// 删
- (void)testRemoveObject {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([setM removeObject:nil]);
#pragma clang diagnostic pop
}

// 改
- (void)testSetSet {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    NSSet *errorSet = @1;
    XCTAssertNoThrow([setM setSet:errorSet]);
#pragma clang diagnostic pop
}

@end
