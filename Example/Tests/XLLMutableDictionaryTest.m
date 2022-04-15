//
//  XLLMutableDictionaryTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/6.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLMutableDictionaryTest : XCTestCase
{
    NSMutableDictionary *dicM;
}

@end

@implementation XLLMutableDictionaryTest

- (void)setUp {
    [super setUp];
    
    dicM = [[NSMutableDictionary alloc] init];
}

- (void)testSetObjectForKey {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([dicM setObject:nil forKey:nil]);
#pragma clang diagnostic pop
}

- (void)testSetValueForKey {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([dicM setValue:nil forKey:nil]);
#pragma clang diagnostic pop
}

- (void)testSetObjectForKeyedSubscript {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow(dicM[nil] = nil);
#pragma clang diagnostic pop
}

- (void)testRemoveObjectForKey {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([dicM removeObjectForKey:nil]);
#pragma clang diagnostic pop
}

@end
