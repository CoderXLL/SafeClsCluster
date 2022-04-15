//
//  XLLArrayTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/2.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLArrayTest : XCTestCase
{
    NSArray *placeholderArray;
    NSArray *array0;
    NSArray *singleObjectArray;
    NSArray *arrayI;
    NSArray *constantArray;
}

@end

@implementation XLLArrayTest

- (void)setUp {
    [super setUp];
    
    // __NSPlacehodlerArray中间对象
    placeholderArray = [NSArray alloc];
    // __NSArray0
    array0 = @[];
    // __NSSingleObjectArrayI
    singleObjectArray = [NSArray arrayWithObjects:@"56", nil];
    // __NSArrayI
    arrayI = [[NSArray alloc] initWithObjects:@"lala", @"haha", nil];
    // NSConstantArray
    constantArray = @[@"lala", @"haha"];
}

- (void)testObjectAtIndex {
    XCTAssertThrows([placeholderArray objectAtIndex:100]);
    XCTAssertNoThrow([array0 objectAtIndex:100]);
    XCTAssertNoThrow([singleObjectArray objectAtIndex:100]);
    XCTAssertNoThrow([arrayI objectAtIndex:100]);
    XCTAssertNoThrow([constantArray objectAtIndex:100]);
}

- (void)testObjectAtIndexedSubscript {
    XCTAssertThrows(placeholderArray[100]);
    XCTAssertNoThrow(array0[100]);
    XCTAssertNoThrow(singleObjectArray[100]);
    XCTAssertNoThrow(arrayI[100]);
    XCTAssertNoThrow(constantArray[100]);
}

@end
