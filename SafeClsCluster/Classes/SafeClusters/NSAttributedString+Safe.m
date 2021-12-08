//
//  NSAttributedString+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/6.
//

#import "NSAttributedString+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 NSConcreteAttributedString
 
 无论是initWithAttributedString:还是initWithString:attributes:，内部都会调用initWithString:。而造成闪退的基本也是这个方法传参为nil导致
 所以hook initWithString:就可以避免闪退。但是为了精确追踪，所以对每一个函数都进行hook
 */
@implementation NSAttributedString (Safe)

+ (void)startSafeAttributedStringProtector {
    if ([[SafeClsCluster sharedInstance].switchManager getSafeAttributedStringSwitchStatus]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class attr = NSClassFromString(@"NSConcreteAttributedString");
            
            // initWithString:
            SEL initWithStrSel = NSSelectorFromString(@"initWithString:");
            SEL safeInitWithStrSel = NSSelectorFromString(@"safe_initWithString:");
            [NSObject exchangeInstanceMethodWithCls:attr originalSel:initWithStrSel swizzleSel:safeInitWithStrSel];
            
            // initWithAttributedString:
            SEL initWithAttrStrSel = NSSelectorFromString(@"initWithAttributedString:");
            SEL safeInitWithAttrStrSel = NSSelectorFromString(@"safe_initWithAttributedString:");
            [NSObject exchangeInstanceMethodWithCls:attr originalSel:initWithAttrStrSel swizzleSel:safeInitWithAttrStrSel];
            
            // initWithString:attributes:
            SEL initWithStrAttributesSel = NSSelectorFromString(@"initWithString:attributes:");
            SEL safeInitWithStrAttributesSel = NSSelectorFromString(@"safe_initWithString:attributes:");
            [NSObject exchangeInstanceMethodWithCls:attr originalSel:initWithStrAttributesSel swizzleSel:safeInitWithStrAttributesSel];
        });
    }
}

+ (void)load {
    
}

- (instancetype)safe_initWithString:(NSString *)str {
    if (!str) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSConcreteAttributedString initWithString:]: nil value" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_initWithString:str];
}

- (instancetype)safe_initWithAttributedString:(NSAttributedString *)attrStr {
    if (!attrStr) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSConcreteAttributedString initWithAttributedString:]: nil value" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_initWithAttributedString:attrStr];
}

- (instancetype)safe_initWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey, id> *)attrs {
    if (!str) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSConcreteAttributedString initWithString:attributes:]: nil value" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_initWithString:str attributes:attrs];
}

@end
