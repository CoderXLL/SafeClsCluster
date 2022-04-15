//
//  XLLAttributedStringTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/6.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLAttributedStringTest : XCTestCase
{
    NSAttributedString *concreteAttributedString;
}

@end

@implementation XLLAttributedStringTest

- (void)setUp {
    [super setUp];
    
    concreteAttributedString = [NSAttributedString alloc];
}

- (void)testInitWithString {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteAttributedString initWithString:nil]);
#pragma clang diagnostic pop
}

- (void)testInitWithAttributedString {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteAttributedString initWithAttributedString:nil]);
#pragma clang diagnostic pop
}

- (void)testInitWithStringAttributes {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertNoThrow([concreteAttributedString initWithString:nil attributes:nil]);
#pragma clang diagnostic pop
}


@end
