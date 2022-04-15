//
//  XLLMutableArrayTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/2.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLMutableArrayTest : XCTestCase
{
    NSMutableArray *placeholderArray;
    NSMutableArray *arrayM;
}

@end

@implementation XLLMutableArrayTest

- (void)setUp {
    [super setUp];
    
    // __NSPlacehodlerArray中间对象
    placeholderArray = [NSMutableArray alloc];
    // __NSArrayM
    arrayM = [NSMutableArray arrayWithObject:@"haha"];
}

// 查
- (void)testObjectAtIndex {
    XCTAssertThrows([placeholderArray objectAtIndex:100]);
    XCTAssertNoThrow([arrayM objectAtIndex:100]);
}

- (void)testObjectAtIndexedSubscript {
    XCTAssertThrows(placeholderArray[100]);
    XCTAssertNoThrow(arrayM[100]);
}

// 增
- (void)testAddObject {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertThrows([placeholderArray addObject:nil]);
    XCTAssertNoThrow([arrayM addObject:nil]);
#pragma clang diagnostic pop
}

- (void)testInsertObjectAtIndex {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertThrows([placeholderArray insertObject:nil atIndex:100]);
    XCTAssertNoThrow([arrayM insertObject:nil atIndex:100]);
#pragma clang diagnostic pop
}

// 删
- (void)testRemoveObjectAtIndex {
    XCTAssertThrows([placeholderArray removeObjectAtIndex:100]);
    XCTAssertNoThrow([arrayM removeObjectAtIndex:100]);
}

- (void)testRemoveObjectInRange {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertThrows([placeholderArray removeObject:nil inRange:NSMakeRange(100, 100)]);
    XCTAssertNoThrow([arrayM removeObject:nil inRange:NSMakeRange(100, 100)]);
#pragma clang diagnostic pop
}

- (void)testRemoveObjectsInRange {
    XCTAssertThrows([placeholderArray removeObjectsInRange:NSMakeRange(100, 100)]);
    XCTAssertNoThrow([arrayM removeObjectsInRange:NSMakeRange(100, 100)]);
}

// 查
- (void)testSetObjectAtIndexedSubscript {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertThrows(placeholderArray[100] = nil);
    XCTAssertNoThrow(arrayM[100] = nil);
#pragma clang diagnostic pop
}

@end
