//
//  NSString+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/3.
//

#import "NSString+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 其中alloc后会优先产出一个中间对象NSPlaceholderString
 __NSCFConstantString：
静态的__NSCFString，通过@""、[NSString new]、@"xxx"初始化的NSString。其引用计数很大，所以其创建后是不会被释放的对象。其大部分实例方法都调用了__NSCFString的对应方法
 
 NSTaggedPointerString：
 在运行时通过stringWithFormat:创建出来的短字符串，是苹果的一种优化手段，将较小的对象直接放在了空余的指针地址中。这货引用计数也很大也是不可被释放
 
 __NSCFString：
 在运行时通过stringWithFormat:创建出来的长字符串或者可变字符串
 */
@implementation NSString (Safe)

+ (void)startSafeStringProtector {
    if ([[SafeClsCluster sharedInstance].switchManager getSafeStringSwitchStatus]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class cfStr = NSClassFromString(@"__NSCFString");
            Class taggedPointerStr = NSClassFromString(@"NSTaggedPointerString");
            Class constStr = NSClassFromString(@"__NSCFConstantString");
            
            // substringFromIndex:
            SEL subStrFromIndexSel = NSSelectorFromString(@"substringFromIndex:");
            
            SEL safeCfSubStrFromIndexSel = NSSelectorFromString(@"safe_cfSubstringFromIndex:");
            SEL safeTaggedPointerStrFromIndexSel = NSSelectorFromString(@"safe_taggedPointerSubstringFromIndex:");
            SEL safeConstStrFromIndexSel = NSSelectorFromString(@"safe_constSubstringFromIndex:");
            
            [NSObject exchangeInstanceMethodWithCls:cfStr originalSel:subStrFromIndexSel swizzleSel:safeCfSubStrFromIndexSel];
            [NSObject exchangeInstanceMethodWithCls:taggedPointerStr originalSel:subStrFromIndexSel swizzleSel:safeTaggedPointerStrFromIndexSel];
            // 其实可不处理，因为__NSCFConstantString的大部分实例方法终归都调用了__NSCFString的对应方法。所以交换了__NSCFString的即可
            [NSObject exchangeInstanceMethodWithCls:constStr originalSel:subStrFromIndexSel swizzleSel:safeConstStrFromIndexSel];
            
            // substringToIndex:
            SEL subStrToIndexSel = NSSelectorFromString(@"substringToIndex:");
            
            SEL safeCfSubStrToIndexSel = NSSelectorFromString(@"safe_cfSubstringToIndex:");
            SEL safeTaggedPointerStrToIndexSel = NSSelectorFromString(@"safe_taggedPointerSubstringToIndex:");
            SEL safeConstStrToIndexSel = NSSelectorFromString(@"safe_constSubstringToIndex:");
            
            [NSObject exchangeInstanceMethodWithCls:cfStr originalSel:subStrToIndexSel swizzleSel:safeCfSubStrToIndexSel];
            [NSObject exchangeInstanceMethodWithCls:taggedPointerStr originalSel:subStrToIndexSel swizzleSel:safeTaggedPointerStrToIndexSel];
            // 其实可不处理，因为__NSCFConstantString的大部分实例方法终归都调用了__NSCFString的对应方法。所以交换了__NSCFString的即可
            [NSObject exchangeInstanceMethodWithCls:constStr originalSel:subStrToIndexSel swizzleSel:safeConstStrToIndexSel];
            
            // substringWithRange:
            SEL subStrWithRangeSel = NSSelectorFromString(@"substringWithRange:");
            
            SEL safeCfSubStrWithRangeSel = NSSelectorFromString(@"safe_cfSubstringWithRange:");
            SEL safeTaggedPointerStrWithRangeSel = NSSelectorFromString(@"safe_taggedPointerSubstringWithRange:");
            SEL safeConstStrWithRangeSel = NSSelectorFromString(@"safe_constSubstringWithRange:");
            
            [NSObject exchangeInstanceMethodWithCls:cfStr originalSel:subStrWithRangeSel swizzleSel:safeCfSubStrWithRangeSel];
            [NSObject exchangeInstanceMethodWithCls:taggedPointerStr originalSel:subStrWithRangeSel swizzleSel:safeTaggedPointerStrWithRangeSel];
            // 其实可不处理，因为__NSCFConstantString的大部分实例方法终归都调用了__NSCFString的对应方法。所以交换了__NSCFString的即可
            [NSObject exchangeInstanceMethodWithCls:constStr originalSel:subStrWithRangeSel swizzleSel:safeConstStrWithRangeSel];
        });
    }
}

+ (void)load {
    
}

#pragma mark - substringFromIndex:
- (NSString *)safe_cfSubstringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSCFString substringFromIndex:]: from out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_cfSubstringFromIndex:from];
}

- (NSString *)safe_taggedPointerSubstringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSTaggedPointerString substringFromIndex:]: from out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_taggedPointerSubstringFromIndex:from];
}

- (NSString *)safe_constSubstringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSCFConstantString substringFromIndex:]: from out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_constSubstringFromIndex:from];
}

#pragma mark - substringToIndex:
- (NSString *)safe_cfSubstringToIndex:(NSUInteger)to {
    if (to > self.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSCFString substringToIndex:]: to out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_cfSubstringToIndex:to];
}

- (NSString *)safe_taggedPointerSubstringToIndex:(NSUInteger)to {
    if (to > self.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSTaggedPointerString substringToIndex:]: to out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_taggedPointerSubstringToIndex:to];
}

- (NSString *)safe_constSubstringToIndex:(NSUInteger)to {
    if (to > self.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[__NSCFConstantString substringToIndex:]: to out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_constSubstringToIndex:to];
}

#pragma mark - substringWithRange:
- (NSString *)safe_cfSubstringWithRange:(NSRange)range {
    if (range.location > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSCFString substringWithRange:]: location out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    if (range.length > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSCFString substringWithRange:]: length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    if ((range.location + range.length) > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSCFString substringWithRange:]: location and length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_cfSubstringWithRange:range];
}

- (NSString *)safe_taggedPointerSubstringWithRange:(NSRange)range {
    if (range.location > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSTaggedPointerString substringWithRange:]: location out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    if (range.length > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSTaggedPointerString substringWithRange:]: length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    if ((range.location + range.length) > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSTaggedPointerString substringWithRange:]: location and length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_taggedPointerSubstringWithRange:range];
}

- (NSString *)safe_constSubstringWithRange:(NSRange)range {
    if (range.location > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSCFConstantString substringWithRange:]: location out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    if (range.length > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSCFConstantString substringWithRange:]: length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    if ((range.location + range.length) > self.length) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSCFConstantString substringWithRange:]: location and length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_constSubstringWithRange:range];
}

@end
