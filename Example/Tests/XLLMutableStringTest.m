//
//  XLLMutableStringTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/6.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLMutableStringTest : XCTestCase
{
    NSMutableString *cfString;
}

@end

@implementation XLLMutableStringTest

- (void)setUp {
    [super setUp];
    
    cfString = [NSMutableString string];
}

- (void)testAppendString {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([cfString appendString:nil]);
#pragma clang diagnostic pop
}

@end
