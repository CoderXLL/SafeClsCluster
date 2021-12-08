//
//  NSMutableArray+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/2.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 removeObjectsInRange:可以兼容removeObjectAtIndex: 反之不可
 说明removeObjectAtIndex:内部最终调用了removeObjectsInRange:方法
 */

@implementation NSMutableArray (Safe)

+ (void)startSafeMutableArrayProtector {
    if ([[SafeClsCluster sharedInstance].switchManager getSafeMutableArraySwitchStatus]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class arrayM = NSClassFromString(@"__NSArrayM");
            // ----------------------- 查 -------------------------
            // objectAtIndex:
            SEL objAtIndexSel = NSSelectorFromString(@"objectAtIndex:");
            SEL safeObjAtIndexSel = NSSelectorFromString(@"safe_objectAtIndex:");
            [NSObject exchangeInstanceMethodWithCls:arrayM originalSel:objAtIndexSel swizzleSel:safeObjAtIndexSel];
            
            // objectAtIndexedSubscript:
            SEL objAtIndexedSubscriptSel = NSSelectorFromString(@"objectAtIndexedSubscript:");
            SEL safeObjAtIndexedSubscriptSel = NSSelectorFromString(@"safe_objectAtIndexedSubscript:");
            [NSObject exchangeInstanceMethodWithCls:arrayM originalSel:objAtIndexedSubscriptSel swizzleSel:safeObjAtIndexedSubscriptSel];
            
            // ----------------------- 增 -------------------------
            // addObject:
            SEL addObjSel = NSSelectorFromString(@"addObject:");
            SEL safeAddObjSel = NSSelectorFromString(@"safe_addObject:");
            [NSObject exchangeInstanceMethodWithCls:arrayM originalSel:addObjSel swizzleSel:safeAddObjSel];
            
            // insertObject:atIndex:
            SEL insertObjAtIndexSel = NSSelectorFromString(@"insertObject:atIndex:");
            SEL safeInsertObjAtIndexSel = NSSelectorFromString(@"safe_insertObject:atIndex:");
            [NSObject exchangeInstanceMethodWithCls:arrayM originalSel:insertObjAtIndexSel swizzleSel:safeInsertObjAtIndexSel];
            
            // ----------------------- 删 -------------------------
            // removeObjectAtIndex:
            SEL removeObjAtIndexSel = NSSelectorFromString(@"removeObjectAtIndex:");
            SEL safeRemoveObjAtIndexSel = NSSelectorFromString(@"safe_removeObjectAtIndex:");
            [NSObject exchangeInstanceMethodWithCls:arrayM originalSel:removeObjAtIndexSel swizzleSel:safeRemoveObjAtIndexSel];
            
            // removeObjectsInRange:
            SEL removeObjsInRangeSel = NSSelectorFromString(@"removeObjectsInRange:");
            SEL safeRemoveObjsInRangeSel = NSSelectorFromString(@"safe_removeObjectsInRange:");
            [NSObject exchangeInstanceMethodWithCls:arrayM originalSel:removeObjsInRangeSel swizzleSel:safeRemoveObjsInRangeSel];
            
            // removeObject:inRange:
            SEL removeObjInRangeSel = NSSelectorFromString(@"removeObject:inRange:");
            SEL safeRemoveObjInRangeSel = NSSelectorFromString(@"safe_removeObject:inRange:");
            [NSObject exchangeInstanceMethodWithCls:arrayM originalSel:removeObjInRangeSel swizzleSel:safeRemoveObjInRangeSel];
            
            // ----------------------- 改 -------------------------
            // setObject:atIndexedSubscript:
            SEL setObjAtIndexedSubscriptSel = NSSelectorFromString(@"setObject:atIndexedSubscript:");
            SEL safeSetObjAtIndexedSubscriptSel = NSSelectorFromString(@"safe_setObject:atIndexedSubscript:");
            [NSObject exchangeInstanceMethodWithCls:arrayM originalSel:setObjAtIndexedSubscriptSel swizzleSel:safeSetObjAtIndexedSubscriptSel];
        });
    }
}

+ (void)load {
    
}

// ----------------------- 查 ------------------------
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

// ----------------------- 增 -------------------------
- (void)safe_addObject:(id)anObject {
    // Nil NULL nil 均可识别，可以加入NSNull
    if (!anObject) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSArrayM addObject:]: object cannot be nil" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_addObject:anObject];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (index > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM insertObject:atIndex:]: index out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_insertObject:anObject atIndex:index];
}

// ----------------------- 删 -------------------------
- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    if (index > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM removeObjectAtIndex:]: index out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    return [self safe_removeObjectAtIndex:index];
}

- (void)safe_removeObject:(id)anObject inRange:(NSRange)range {
    if (range.location > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM removeObject:inRange:]: location out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (range.length > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM removeObject:inRange:]: length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if ((range.location + range.length) > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM removeObject:inRange:]: location and length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    return [self safe_removeObject:anObject inRange:range];
}

- (void)safe_removeObjectsInRange:(NSRange)range {
    if (range.location > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM removeObjectsInRange:]: location out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (range.length > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM removeObjectsInRange:]: length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if ((range.location + range.length) > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM removeObjectsInRange:]: location and length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    return [self safe_removeObjectsInRange:range];
}

- (void)safe_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index {
    if (index > self.count) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSArrayM setObject:atIndexedSubscript:]: index out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (!anObject) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSArrayM setObject:atIndexedSubscript:]: object cannot be nil" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    return [self safe_setObject:anObject atIndexedSubscript:index];
}

@end
