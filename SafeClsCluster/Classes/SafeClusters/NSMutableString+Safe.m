//
//  NSMutableString+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/3.
//

#import "NSMutableString+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 __NSCFString
 */
@implementation NSMutableString (Safe)

+ (void)startSafeMutableStringProtector {
    if ([[SafeClsCluster sharedInstance].switchManager getSafeMutableStringSwitchStatus]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class cfStr = NSClassFromString(@"__NSCFString");
            
            // appendString:
            SEL appendStrSel = NSSelectorFromString(@"appendString:");
            SEL safeAppendStrSel = NSSelectorFromString(@"safe_appendString:");
            [NSObject exchangeInstanceMethodWithCls:cfStr originalSel:appendStrSel swizzleSel:safeAppendStrSel];
        });
    }
}

+ (void)load {
    
}

- (void)safe_appendString:(NSString *)aString {
    if (!aString) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[__NSCFString appendString:]: nil argument" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_appendString:aString];
}

@end
