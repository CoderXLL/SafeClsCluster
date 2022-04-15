//
//  XLLDictionaryTest.m
//  SafeClsCluster_Tests
//
//  Created by 肖乐乐 on 2022/4/6.
//  Copyright © 2022 肖乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XLLDictionaryTest : XCTestCase
{
    NSDictionary *placeholderDic;
    NSDictionary *dic0;
    NSDictionary *singleEntryDicI;
    NSDictionary *dicI;
    NSDictionary *constantDic;
}

@end

@implementation XLLDictionaryTest

- (void)setUp {
    [super setUp];
    
    // 中间对象__NSPlaceholderDictionary
    placeholderDic = [NSDictionary alloc];
    // __NSDictionary0：@{}、[[NSDictionary alloc] init]、[NSDictionary new] 即没有键值对的NSDictionary
    dic0 = [[NSDictionary alloc] init];
    // __NSSingleEntryDictionaryI：不使用大括号直接初始化，且只有一个键值对的NSDictionary
    singleEntryDicI = [[NSDictionary alloc] initWithDictionary:@{@"lala": @"haha"}];
    // __NSDictionaryI：不使用大括号直接初始化，有一个以上键值对的NSDictionary
    dicI = [[NSDictionary alloc] initWithObjects:@[@"heiheihei", @"nananan"] forKeys:@[@"1", @"2", @"3"]];
    // NSConstantDictionary：通过大括号方式初始化，一个即以上成员的NSDictionary
    constantDic = @{@"lala": @"b"};
}

- (void)testInitWithObjectsForKeys {
    NSArray *objects = @[];
    NSArray *keys = @[@"1", @"2"];
    XCTAssertNoThrow([placeholderDic initWithObjects:objects forKeys:keys]);
    XCTAssertThrows([dic0 initWithObjects:objects forKeys:keys]);
    XCTAssertThrows([singleEntryDicI initWithObjects:objects forKeys:keys]);
    XCTAssertNoThrow([dicI initWithObjects:objects forKeys:keys]);
    XCTAssertThrows([constantDic initWithObjects:objects forKeys:keys]);
}

- (void)testSetValueForUndefinedKey {
    
}


@end
