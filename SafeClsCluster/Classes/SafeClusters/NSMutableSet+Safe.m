//
//  NSMutableSet+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import "NSMutableSet+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 __NSSetM
 */
@implementation NSMutableSet (Safe)

+ (void)startSafeMutableSetProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class setM = NSClassFromString(@"__NSSetM");
        
        // ----------------------- 增 -------------------------
        // addObject:
        SEL addObjSel = NSSelectorFromString(@"addObject:");
        SEL safeAddObjSel = NSSelectorFromString(@"safe_addObject:");
        [NSObject exchangeInstanceMethodWithCls:setM originalSel:addObjSel swizzleSel:safeAddObjSel];
        
        // ----------------------- 删 -------------------------
        // removeObject:
        SEL removeObjSel = NSSelectorFromString(@"removeObject:");
        SEL safeRemoveObjSel = NSSelectorFromString(@"safe_removeObject:");
        [NSObject exchangeInstanceMethodWithCls:setM originalSel:removeObjSel swizzleSel:safeRemoveObjSel];
        
        // ----------------------- 改 -------------------------
        // setSet:
        SEL setSetSel = NSSelectorFromString(@"setSet:");
        SEL safeSetSetSel = NSSelectorFromString(@"safe_setSet:");
        [NSObject exchangeInstanceMethodWithCls:setM originalSel:setSetSel swizzleSel:safeSetSetSel];
    });
}

+ (void)load {
    
}

- (void)safe_addObject:(id)object {
    if (!object) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSSetM addObject:]: nil argument" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_addObject:object];
}

- (void)safe_removeObject:(id)object {
    if (!object) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSSetM removeObject:]: nil argument" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_removeObject:object];
}

- (void)safe_setSet:(NSSet *)otherSet {
    if (![otherSet isKindOfClass:[NSSet class]]) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSSetM setSet:]: set argument is not an NSSet" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    return [self safe_setSet:otherSet];
}

@end
