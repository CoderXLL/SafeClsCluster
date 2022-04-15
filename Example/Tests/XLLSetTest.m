//
//  XLLSetTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/6.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLSetTest : XCTestCase
{
    NSSet *placeholderSet;
    NSSet *singleObjectSetI;
    NSSet *setI;
}

@end

@implementation XLLSetTest

- (void)setUp {
    [super setUp];
    
    // __NSPlaceholderSet
    placeholderSet = [NSSet alloc];
    // __NSSingleObjectSetI：initWithObjects:、initWithArray:初始化，且只有一个成员的NSSet
    singleObjectSetI = [[NSSet alloc] initWithObjects:@"test", nil];
    // __NSSetI：有0个或1个以上成员的NSSet
    setI = [[NSSet alloc] initWithArray:@[@"1", @"2"]];
}

- (void)testSetWithObject {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([NSSet setWithObject:nil]);
#pragma clang diagnostic pop
}

- (void)testSetByAddingObject {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([placeholderSet setByAddingObject:nil]);
    XCTAssertNoThrow([singleObjectSetI setByAddingObject:nil]);
    XCTAssertNoThrow([setI setByAddingObject:nil]);
#pragma clang diagnostic pop
}

- (void)testIntersectsSet {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    NSSet *errorSet = @1;
    XCTAssertNoThrow([placeholderSet intersectsSet:errorSet]);
    XCTAssertNoThrow([singleObjectSetI intersectsSet:errorSet]);
    XCTAssertNoThrow([setI intersectsSet:errorSet]);
#pragma clang diagnostic pop
}

- (void)testIsEqualToSet {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    NSSet *errorSet = @1;
    XCTAssertNoThrow([placeholderSet isEqualToSet:errorSet]);
    XCTAssertNoThrow([singleObjectSetI isEqualToSet:errorSet]);
    XCTAssertNoThrow([setI isEqualToSet:errorSet]);
#pragma clang diagnostic pop
}

- (void)testIsSubsetOfSet {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    NSSet *errorSet = @1;
    XCTAssertNoThrow([placeholderSet isSubsetOfSet:errorSet]);
    XCTAssertNoThrow([singleObjectSetI isSubsetOfSet:errorSet]);
    XCTAssertNoThrow([setI isSubsetOfSet:errorSet]);
#pragma clang diagnostic pop
}

@end
