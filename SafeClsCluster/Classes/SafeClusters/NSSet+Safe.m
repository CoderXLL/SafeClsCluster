//
//  NSSet+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import "NSSet+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
其中alloc后会优先产出一个中间对象__NSPlaceholderSet
__NSSingleObjectSetI：initWithObjects:、initWithArray:初始化，且只有一个成员的NSSet
 
__NSSetI：有0个或1个以上成员的NSSet
 
 */
@implementation NSSet (Safe)

+ (void)startSafeSetProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        Class singleObjectSet = NSClassFromString(@"__NSSingleObjectSetI");
//        Class setI = NSClassFromString(@"__NSSetI");
        Class set = NSClassFromString(@"NSSet");
        
        // setWithObject:
        SEL setWithObjSel = NSSelectorFromString(@"setWithObject:");
        SEL safeSetWithObjSel = NSSelectorFromString(@"safe_setWithObject:");
        [NSObject exchangeClassMethodWithCls:set originalSel:setWithObjSel swizzleSel:safeSetWithObjSel];
        
        // 这些方法不需要打扰实际的哈希表，竟然可以直接hook NSSet ???
        // setByAddingObject:
        SEL setByAddingObjSel = NSSelectorFromString(@"setByAddingObject:");
        
        SEL safeSetByAddingObjSel = NSSelectorFromString(@"safe_setByAddingObject:");
        [NSObject exchangeInstanceMethodWithCls:set originalSel:setByAddingObjSel swizzleSel:safeSetByAddingObjSel];
//        SEL safeSingleSetByAddingObjSel = NSSelectorFromString(@"safe_singleSetByAddingObject:");
//
//        [NSObject exchangeInstanceMethodWithCls:setI originalSel:setByAddingObjSel swizzleSel:safeSetByAddingObjSel];
//        [NSObject exchangeInstanceMethodWithCls:singleObjectSet originalSel:setByAddingObjSel swizzleSel:safeSingleSetByAddingObjSel];
        
        // intersectsSet:
        SEL intersectsSetSel = NSSelectorFromString(@"intersectsSet:");
        SEL safeIntersectsSetSel = NSSelectorFromString(@"safe_intersectsSet:");
        [NSObject exchangeInstanceMethodWithCls:set originalSel:intersectsSetSel swizzleSel:safeIntersectsSetSel];
        
        // isEqualToSet:
        SEL isEqualToSetSel = NSSelectorFromString(@"isEqualToSet:");
        SEL safeIsEqualToSetSel = NSSelectorFromString(@"safe_isEqualToSet:");
        [NSObject exchangeInstanceMethodWithCls:set originalSel:isEqualToSetSel swizzleSel:safeIsEqualToSetSel];
        
        // isSubsetOfSet:
        SEL isSubsetOfSetSel = NSSelectorFromString(@"isSubsetOfSet:");
        SEL safeIsSubsetOfSetSel = NSSelectorFromString(@"safe_isSubsetOfSet:");
        [NSObject exchangeInstanceMethodWithCls:set originalSel:isSubsetOfSetSel swizzleSel:safeIsSubsetOfSetSel];
    });
}

+ (void)load {
    
}

+ (instancetype)safe_setWithObject:(id)object {
    if (!object) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** +[NSSet setWithObject:]: nil argument" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_setWithObject:object];
}

- (NSSet *)safe_setByAddingObject:(id)anObject {
    if (!anObject) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSSet setByAddingObject:]: nil argument" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return self;
    }
    return [self safe_setByAddingObject:anObject];
}

//- (NSSet *)safe_singleSetByAddingObject:(id)anObject {
//    if (!anObject) {
//        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSSingleObjectSetI setByAddingObject:]: nil argument" userInfo:nil];
//        NSLog(@"%@", exception);
//        return self;
//    }
//    return [self safe_singleSetByAddingObject:anObject];
//}

- (BOOL)safe_intersectsSet:(NSSet *)otherSet {
    if (![otherSet isKindOfClass:[NSSet class]]) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSSet intersectsSet:]: set argument is not an NSSet" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return NO;
    }
    return [self safe_intersectsSet:otherSet];
}

- (BOOL)safe_isEqualToSet:(NSSet *)otherSet {
    if (![otherSet isKindOfClass:[NSSet class]]) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSSet isEqualToSet:]: set argument is not an NSSet" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return NO;
    }
    return [self safe_isEqualToSet:otherSet];
}

- (BOOL)safe_isSubsetOfSet:(NSSet *)otherSet {
    if (![otherSet isKindOfClass:[NSSet class]]) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSSet isSubsetOfSet:]: set argument is not an NSSet" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return NO;
    }
    return [self safe_isSubsetOfSet:otherSet];
}

@end
