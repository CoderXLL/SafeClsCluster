//
//  XLLMutableAttributedStringTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/6.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLMutableAttributedStringTest : XCTestCase
{
    NSMutableAttributedString *concreteMutableAttributedString;
}

@end

@implementation XLLMutableAttributedStringTest

- (void)setUp {
    [super setUp];
    
    concreteMutableAttributedString = [NSMutableAttributedString alloc];
}

- (void)testInitWithString {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteMutableAttributedString initWithString:nil]);
#pragma clang diagnostic pop
}

- (void)testInitWithStringAttributes {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteMutableAttributedString initWithString:nil attributes:nil]);
#pragma clang diagnostic pop
}

// 增
- (void)testAppendAttributedString {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteMutableAttributedString appendAttributedString:nil]);
#pragma clang diagnostic pop
}

- (void)testInsertAttributedStringAtIndex {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteMutableAttributedString insertAttributedString:nil atIndex:100]);
#pragma clang diagnostic pop
}

// 删
- (void)testDeleteCharactersInRange {
    XCTAssertNoThrow([concreteMutableAttributedString deleteCharactersInRange:NSMakeRange(100, 100)]);
}

// 改
- (void)testReplaceCharactersInRangeWithString {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteMutableAttributedString replaceCharactersInRange:NSMakeRange(100, 100) withString:nil]);
#pragma clang diagnostic pop
}

- (void)testReplaceCharactersInRangeWithAttributedString {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteMutableAttributedString replaceCharactersInRange:NSMakeRange(100, 100) withAttributedString:nil]);
#pragma clang diagnostic pop
}

@end
