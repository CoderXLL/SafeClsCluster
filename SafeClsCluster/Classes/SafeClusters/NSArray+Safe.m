//
//  NSArray+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/1.
//

#import "NSArray+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 NSArray类簇，运用工厂模式初始化后分别有根据情况生产出不同的类对象。 其中alloc后会优先产出一个中间对象__NSPlacehodlerArray
 __NSArray0：
 - @[]、[[NSArray alloc] init]、[NSArray new]、[NSArray arrayWithObjects:nil, nil] 即没有成员的NSArray
 - 其两种访问成员方式 array[4]、[array objectAtIndex:4] 都是触发objectAtIndex:方法
 
 __NSSingleObjectArrayI：
 - [NSArray arrayWithObjects:@"哈哈", nil]、[NSArray arrayWithObject:@"haha"] 通过arrayWithObjects初始化，且只有一个成员的NSArray
 - 其两种访问成员方式 array[4]、[array objectAtIndex:4] 都是触发objectAtIndex:方法
 
 __NSArrayI：
 - [[NSArray alloc] initWithObjects:@"lala", @"haha", nil] 通过arrayWithObjects初始化、且有一个以上成员的NSArray
 - 其访问成员方式 array[4] 触发objectAtIndexedSubscript:方法、[array objectAtIndex:4] 触发objectAtIndex:方法
 
 NSConstantArray：
 - @[@"lala", @"haha"] 通过中括号方式初始化，一个即以上成员的NSArray
 - 其访问成员方式 array[4] 触发objectAtIndexedSubscript:方法、[array objectAtIndex:4] 触发objectAtIndex:方法
 */

@implementation NSArray (Safe)

+ (void)startSafeArrayProtector {
    if ([[SafeClsCluster sharedInstance].switchManager getSafeArraySwitchStatus]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class array0 = NSClassFromString(@"__NSArray0");  //没有成员的NSArray
            Class singleObjectArray = NSClassFromString(@"__NSSingleObjectArrayI");  //只有一个成员的NSArray
            Class arrayI = NSClassFromString(@"__NSArrayI"); //有多于一个成员的NSArray
            Class constantArray = NSClassFromString(@"NSConstantArray");
            
            // objectAtIndex:
            SEL objAtIndexSel = NSSelectorFromString(@"objectAtIndex:");
            
            SEL safeZeroObjAtIndexSel = NSSelectorFromString(@"safe_zeroObjectAtIndex:");
            SEL safeSingleObjAtIndexSel = NSSelectorFromString(@"safe_singleObjectAtIndex:");
            SEL safeObjAtIndexSel = NSSelectorFromString(@"safe_objectAtIndex:");
            SEL safeConstObjAtIndexSel = NSSelectorFromString(@"safe_constantObjectAtIndex:");
            
            [NSObject exchangeInstanceMethodWithCls:array0 originalSel:objAtIndexSel swizzleSel:safeZeroObjAtIndexSel];
            [NSObject exchangeInstanceMethodWithCls:singleObjectArray originalSel:objAtIndexSel swizzleSel:safeSingleObjAtIndexSel];
            [NSObject exchangeInstanceMethodWithCls:arrayI originalSel:objAtIndexSel swizzleSel:safeObjAtIndexSel];
            [NSObject exchangeInstanceMethodWithCls:constantArray originalSel:objAtIndexSel swizzleSel:safeConstObjAtIndexSel];
            
            // objectAtIndexedSubscript:
            SEL objAtIndexedSubscriptSel = NSSelectorFromString(@"objectAtIndexedSubscript:");
            
            SEL safeObjAtIndexedSubscriptSel = NSSelectorFromString(@"safe_objectAtIndexedSubscript:");
            SEL safeConstObjAtIndexedSubscriptSel = NSSelectorFromString(@"safe_constantObjectAtIndexedSubscript:");
            
            [NSObject exchangeInstanceMethodWithCls:arrayI originalSel:objAtIndexedSubscriptSel swizzleSel:safeObjAtIndexedSubscriptSel];
            [NSObject exchangeInstanceMethodWithCls:constantArray originalSel:objAtIndexedSubscriptSel swizzleSel:safeConstObjAtIndexedSubscriptSel];
        });
    }
}

+ (void)load {
    
}

- (id)safe_zeroObjectAtIndex:(NSUInteger)index {
    id object = nil;
    NSException *catchedException = nil;
    @try {
        object = [self safe_zeroObjectAtIndex:index];
    } @catch (NSException *exception) {
        catchedException = exception;
    } @finally {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:catchedException];
        return object;
    }
}

- (id)safe_singleObjectAtIndex:(NSUInteger)index {
    id object = nil;
    NSException *catchedException = nil;
    @try {
        object = [self safe_singleObjectAtIndex:index];
    } @catch (NSException *exception) {
        catchedException = exception;
    } @finally {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:catchedException];
        return object;
    }
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    id object = nil;
    NSException *catchedException = nil;
    @try {
        object = [self safe_objectAtIndex:index];
    } @catch (NSException *exception) {
        catchedException = exception;
    } @finally {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:catchedException];
        return object;
    }
}

- (id)safe_constantObjectAtIndex:(NSUInteger)index {
    id object = nil;
    NSException *catchedException = nil;
    @try {
        object = [self safe_constantObjectAtIndex:index];
    } @catch (NSException *exception) {
        catchedException = exception;
    } @finally {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:catchedException];
        return object;
    }
}

// -------------------------------------------------------------

- (id)safe_objectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    NSException *catchedException = nil;
    @try {
        object = [self safe_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        catchedException = exception;
    } @finally {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:catchedException];
        return object;
    }
}

- (id)safe_constantObjectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    NSException *catchedException = nil;
    @try {
        object = [self safe_constantObjectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        catchedException = exception;
    } @finally {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:catchedException];
        return object;
    }
}

@end
