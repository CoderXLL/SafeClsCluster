//
//  NSMutableDictionary+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/3.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 setObject:forKey:可以兼容setValue:forKey:反之不可
 说明setValue:forKey:内部最终调用了setObject:forKey:方法
 */

@implementation NSMutableDictionary (Safe)

+ (void)startSafeMutableDictionaryProtector {
    if ([[SafeClsCluster sharedInstance].switchManager getSafeMutableDictionarySwitchStatus]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class dictM = NSClassFromString(@"__NSDictionaryM");
            
            // setObject:forKey:
            SEL setObjForKSel = NSSelectorFromString(@"setObject:forKey:");
            SEL safeSetObjForKSel = NSSelectorFromString(@"safe_setObject:forKey:");
            [NSObject exchangeInstanceMethodWithCls:dictM originalSel:setObjForKSel swizzleSel:safeSetObjForKSel];
            
            // 隶属于NSObject(NSKeyValueCoding)
            // setValue:forKey:
            SEL setVForKSel = NSSelectorFromString(@"setValue:forKey:");
            SEL safeSetVForKSel = NSSelectorFromString(@"safe_setValue:forKey:");
            [NSObject exchangeInstanceMethodWithCls:dictM originalSel:setVForKSel swizzleSel:safeSetVForKSel];
            
            // setObject:forKeyedSubscript:
            SEL setObjForKSubscriptSel = NSSelectorFromString(@"setObject:forKeyedSubscript:");
            SEL safeSetObjForKSubscriptSel = NSSelectorFromString(@"safe_setObject:forKeyedSubscript:");
            [NSObject exchangeInstanceMethodWithCls:dictM originalSel:setObjForKSubscriptSel swizzleSel:safeSetObjForKSubscriptSel];
            
            // removeObjectForKey:
            SEL removeObjForKSel = NSSelectorFromString(@"removeObjectForKey:");
            SEL safeRemoveObjForKSel = NSSelectorFromString(@"safe_removeObjectForKey:");
            [NSObject exchangeInstanceMethodWithCls:dictM originalSel:removeObjForKSel swizzleSel:safeRemoveObjForKSel];
        });
    }
}

+ (void)load {
    
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)akey {
    @try {
        [self safe_setObject:anObject forKey:akey];
    } @catch (NSException *exception) {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
    }
}

- (void)safe_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self safe_setValue:value forKey:key];
    } @catch (NSException *exception) {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
    }
}

- (void)safe_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self safe_setObject:anObject forKeyedSubscript:key];
    } @catch (NSException *exception) {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
    }
}

- (void)safe_removeObjectForKey:(id<NSCopying>)aKey {
    @try {
        [self safe_removeObjectForKey:aKey];
    } @catch (NSException *exception) {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
    }
}

@end
