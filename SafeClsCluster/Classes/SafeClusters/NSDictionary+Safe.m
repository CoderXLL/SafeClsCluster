//
//  NSDictionary+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/3.
//

#import "NSDictionary+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 其中alloc后会优先产出一个中间对象__NSPlaceholderDictionary
 __NSDictionary0：
 @{}、、[[NSDictionary alloc] init]、[NSDictionary new] 即没有键值对的NSDictionary
 
 __NSSingleEntryDictionaryI：
 不使用大括号直接初始化，且只有一个键值对的NSDictionary
 
__NSDictionaryI：
 不使用大括号直接初始化，有一个以上键值对的NSDictionary
 
 NSConstantDictionary：
 通过大括号方式初始化，一个即以上成员的NSDictionary
 
 key为nil、Nil、NULL、[NSNull null]都不会造成crash，所以不用hook其getter方法
 */
@implementation NSDictionary (Safe)

+ (void)startSafeDictionaryProtector {
    if ([[SafeClsCluster sharedInstance].switchManager getSafeDictionarySwitchStatus]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class placeholderDic = NSClassFromString(@"__NSPlaceholderDictionary");
            Class dic0 = NSClassFromString(@"__NSDictionary0");
            Class singleEntryDic = NSClassFromString(@"__NSSingleEntryDictionaryI");
            Class dicI = NSClassFromString(@"__NSDictionaryI");
            Class constantDic = NSClassFromString(@"NSConstantDictionary");
            
            // initWithObjects:forKeys:
            SEL objsForKeysSel = NSSelectorFromString(@"initWithObjects:forKeys:");
            SEL safeObjsForKeysSel = NSSelectorFromString(@"safe_initWithObjects:forKeys:");
            [NSObject exchangeInstanceMethodWithCls:placeholderDic originalSel:objsForKeysSel swizzleSel:safeObjsForKeysSel];
            
            // initWithObjects:forKeys:count:
            SEL objsForKeysCountSel = NSSelectorFromString(@"initWithObjects:forKeys:count:");
            SEL safeObjsForKeysCountSel = NSSelectorFromString(@"safe_initWithObjects:forKeys:count:");
            [NSObject exchangeInstanceMethodWithCls:placeholderDic originalSel:objsForKeysCountSel swizzleSel:safeObjsForKeysCountSel];
            
            // 隶属于NSObject(NSKeyValueCoding)
            // setValue:forUndefinedKey:
            SEL setVForUndefinedKSel = NSSelectorFromString(@"setValue:forUndefinedKey:");
            
            SEL safeZeroSetVForUndefinedKSel = NSSelectorFromString(@"safe_zeroSetValue:forUndefinedKey:");
            SEL safeSingleSetVForUndefinedKSel = NSSelectorFromString(@"safe_singleSetValue:forUndefinedKey:");
            SEL safeSetForUndefinedKSel = NSSelectorFromString(@"safe_setValue:forUndefinedKey:");
            SEL safeConstSetVForUndefinedKSel = NSSelectorFromString(@"safe_ConstSetValue:forUndefinedKey:");
            
            [NSObject exchangeInstanceMethodWithCls:dic0 originalSel:setVForUndefinedKSel swizzleSel:safeZeroSetVForUndefinedKSel];
            [NSObject exchangeInstanceMethodWithCls:singleEntryDic originalSel:setVForUndefinedKSel swizzleSel:safeSingleSetVForUndefinedKSel];
            [NSObject exchangeInstanceMethodWithCls:dicI originalSel:setVForUndefinedKSel swizzleSel:safeSetForUndefinedKSel];
            [NSObject exchangeInstanceMethodWithCls:constantDic originalSel:setVForUndefinedKSel swizzleSel:safeConstSetVForUndefinedKSel];
        });
    }
}

+ (void)load {
    
}

- (instancetype)safe_initWithObjects:(NSArray *)objects forKeys:(NSArray <NSCopying> *)keys {
    id instance = nil;
    NSException *catchedException = nil;
    @try {
        instance = [self safe_initWithObjects:objects forKeys:keys];
    } @catch (NSException *exception) {
        catchedException = exception;
    } @finally {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:catchedException];
        return instance;
    }
}

- (instancetype)safe_initWithObjects:(const id *)objects forKeys:(const id <NSCopying> *)keys count:(NSUInteger)cnt {
    id instance = nil;
    NSException *catchedException = nil;
    @try {
        instance = [self safe_initWithObjects:objects forKeys:keys count:cnt];
    } @catch (NSException *exception) {
        catchedException = exception;
    } @finally {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:catchedException];
        return instance;
    }
}

- (void)safe_zeroSetValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self safe_zeroSetValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
    }
}

- (void)safe_singleSetValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self safe_singleSetValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
    }
}

- (void)safe_setValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self safe_setValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
    }
}

- (void)safe_ConstSetValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self safe_ConstSetValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
    }
}

@end
