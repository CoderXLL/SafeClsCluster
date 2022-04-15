//
//  XLLStringTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/6.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLStringTest : XCTestCase
{
    NSString *placeholderString;
    NSString *constantString;
    NSString *taggedPointerString;
    NSString *cfString;
}

@end

@implementation XLLStringTest

- (void)setUp {
    [super setUp];
    
    // NSPlaceholderString：
    placeholderString = [NSString alloc];
    // __NSCFConstantString：
    constantString = [NSString new];
    // NSTaggedPointerString：在运行时通过stringWithFormat:创建出来的短字符串
    taggedPointerString = [NSString stringWithFormat:@"123"];
    // __NSCFString：在运行时通过stringWithFormat:创建出来的长字符串或者可变字符串
    cfString = [NSString stringWithFormat:@"dlsjflsjkdfsldjfwijeorjfiojsdkljfoiwejfoijeoi123424jklsdfls"];
}

- (void)testSubstringFromIndex {
    XCTAssertThrows([placeholderString substringFromIndex:100]);
    XCTAssertNoThrow([constantString substringFromIndex:100]);
    XCTAssertNoThrow([taggedPointerString substringFromIndex:100]);
    XCTAssertNoThrow([cfString substringFromIndex:100]);
}

- (void)testSubstringToIndex {
    XCTAssertThrows([placeholderString substringToIndex:100]);
    XCTAssertNoThrow([constantString substringToIndex:100]);
    XCTAssertNoThrow([taggedPointerString substringToIndex:100]);
    XCTAssertNoThrow([cfString substringToIndex:100]);
}

- (void)testSubstringWithRange {
    XCTAssertThrows([placeholderString substringWithRange:NSMakeRange(100, 100)]);
    XCTAssertNoThrow([constantString substringWithRange:NSMakeRange(100, 100)]);
    XCTAssertNoThrow([taggedPointerString substringWithRange:NSMakeRange(100, 100)]);
    XCTAssertNoThrow([cfString substringWithRange:NSMakeRange(100, 100)]);
}

@end
