//
//  XLLViewController.m
//  SafeClsCluster
//
//  Created by 肖乐 on 12/08/2021.
//  Copyright (c) 2021 肖乐. All rights reserved.
//

#import "XLLViewController.h"
#import "SafeClsCluster.h"

@interface XLLViewController ()

@end

@implementation XLLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[SafeClsCluster sharedInstance].switchManager openAllSafeSwitch];
    [[SafeClsCluster sharedInstance].exceptionManager setupExceptionDebugDealWay:ExceptionDebugDealWayLog];
    
    // NSArray
//    // __NSPlacehodlerArray中间对象
//    NSArray *placehodlerArray = [NSArray alloc];
//    // __NSArray0
//    NSArray *array0 = @[];
//    // __NSSingleObjectArrayI
//    NSArray *singleObjectArray = [NSArray arrayWithObjects:@"56", nil];
//    // __NSArrayI
//    NSArray *arrayI = [[NSArray alloc] initWithObjects:@"lala", @"haha", nil];
//    // NSConstantArray
//    NSArray *constantArray = @[@"lala", @"haha"];
    
//    [array0 objectAtIndex:100];
//    NSLog(@"%@", array0[10]);
//    NSLog(@"%@", singleObjectArray[10]);
//    NSLog(@"%@", [arrayI objectAtIndex:10]);
//    NSLog(@"%@", [constantArray objectAtIndex:10]);
//
//    NSLog(@"%@", arrayI[10]);
//    NSLog(@"%@", constantArray[10]);
     
    
    // NSMutableArray
    // __NSPlacehodlerArray中间对象
//    NSMutableArray *placeholderArray = [NSMutableArray alloc];
    // __NSArrayM
//    NSMutableArray *arrayM = [NSMutableArray arrayWithObject:@"haha"];
    
//    查
//    NSLog(@"%@", [arrayM objectAtIndex:10]);
//    NSLog(@"%@", arrayM[10]);
    
//    增
//    [arrayM addObject:Nil];
//    [arrayM insertObject:nil atIndex:0];
//    [arrayM removeObject:nil inRange:NSMakeRange(10, 1)];
//    [arrayM removeObjectAtIndex:10];
//    [arrayM removeObjectsInRange:NSMakeRange(10, 1)];
    
//    改
//    arrayM[1] = nil;
    
//    // NSDictionary
//    NSDictionary *placeholderDictionary = [NSDictionary alloc];
//    NSDictionary *lala = [[NSDictionary alloc] init];
//    NSDictionary *heihei = [[NSDictionary alloc] initWithDictionary:@{@"lala": @"haha"}];
//    NSDictionary *nana = [[NSDictionary alloc] initWithObjects:@[@"heiheihei", @"nananan"] forKeys:@[@"1", @"2", @"3"]];
//    NSDictionary *baba = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"heihei", @"2", @"lala", nil];
//    NSDictionary *jiujiu = @{
//        @"lala": @"b"
//    };
//    setValue:forUndefinedKey:
//    NSMutableDictionary *dictM = @{
//        @"1": @"haha"
//    };
//    [dictM setValue:@"heihei" forUndefinedKey:@"sdf"];
//
//    NSLog(@"%@", [heihei objectForKey:@"lala"]);
    
//    // NSMutableDictionary
//    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:@{@"haha": @"1"}];
//    dictM[nil] = @"555";
//    [dictM removeObjectForKey:nil];
    
//    // NSString
//    NSString *placeholderStr = [NSString alloc];
//    NSString *constStr1 = [NSString new];
//    NSString *constStr2 = @"";
//    NSString *constStr3 = @"heihei";
//    NSString *taggedPointerStr = [NSString stringWithFormat:@"sdfdssdfjsl"];
//    NSString *cfStr = [NSString stringWithFormat:@"dsfsdsdfjlksdjfklsdkjdsfjklsjfdljfkldjsflksjflkjdsljfsdjfldsjffj"];
//    [constStr1 substringToIndex:1000];
//    [cfStr substringWithRange:NSMakeRange(0, 1000)];
//    [haha substringToIndex:100];
    
//    // NSMutableString
//    NSMutableString *strM = [NSMutableString string];
//    [strM appendString:nil];
    
//    // NSAttributeString
//    NSAttributedString *placeholderAttr = [NSAttributedString alloc];
//    NSAttributedString *attr = [[NSAttributedString alloc] init];
////    NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:NULL];
//
////    NSAttributedString *attr3 = [[NSAttributedString alloc] initWithAttributedString:nil];
//    NSAttributedString *attr4 = [[NSAttributedString alloc] initWithString:@"haha" attributes:nil];
    
    // NSMutableAttributeString
//    NSMutableAttributedString *attrM1 = [[NSMutableAttributedString alloc] initWithString:@"haha"];
//    NSMutableAttributedString *attrM2 = [[NSMutableAttributedString alloc] initWithString:@"geigei" attributes:nil];
////    增
//    [attrM2 appendAttributedString:nil];
//    [attrM2 insertAttributedString:[[NSAttributedString alloc] initWithString:@"haha"] atIndex:6];
    
//    删
//    [attrM2 deleteCharactersInRange:NSMakeRange(6, 1)];
    
//    改
//    [attrM2 replaceCharactersInRange:NSMakeRange(6, 0) withString:@"haha"];
//    [attrM2 replaceCharactersInRange:NSMakeRange(6, 0) withAttributedString:nil];
    
//    NSSet
    NSSet *set1 = [NSSet alloc];
    NSSet *set2 = [[NSSet alloc] init];
    NSSet *set3 = [[NSSet alloc] initWithArray:@[@"1"]];
    NSSet *set4 = [[NSSet alloc] initWithArray:@[@"1", @"2"]];
    NSSet *set5 = [[NSSet alloc] initWithObjects:@"3", nil];
    NSSet *set6 = [[NSSet alloc] initWithObjects:@"3", @"4", nil];
    
//    NSSet *set7 = [NSSet setWithObject:nil]; //会崩溃
//    NSSet *set8 = [[NSSet alloc] initWithArray:nil];
//    NSSet *set9 = [[NSSet alloc] initWithObjects:nil, nil];
//    NSSet *set10 = [NSSet setWithSet:nil];
//    NSSet *set11 = [[NSSet alloc] initWithSet:nil copyItems:NO];
//    NSSet *set12 = [[NSSet alloc] initWithObjects:nil count:0];
    
//    [set6 setByAddingObject:nil];
//    [set6 setByAddingObjectsFromArray:nil];
    
    
    NSSet *lala = @[@"1"];
//    [set5 intersectsSet:lala];
//    [set5 isEqualToSet:lala];
//    [set5 isSubsetOfSet:lala];
//    - (BOOL)isEqualToSet:(NSSet<ObjectType> *)otherSet;
//    - (BOOL)isSubsetOfSet:(NSSet<ObjectType> *)otherSet;
    
//    NSMutableSet
    NSMutableSet *setM1 = [[NSMutableSet alloc] init];
//    [setM1 addObject:nil];
//    [setM1 removeObject:nil];
//    [setM1 setSet:lala];
    [setM1 setByAddingObject:nil];
    
    
//    [self haha];
}

//- (void)haha {
//    NSArray *lala = @[@"haha"];
//    @try {
//        [lala objectAtIndex:100];
//    } @catch (NSException *exception) {
//        @throw exception;
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

