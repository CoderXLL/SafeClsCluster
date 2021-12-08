//
//  NSMutableAttributedString+Safe.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/6.
//

#import "NSMutableAttributedString+Safe.h"
#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"

/**
 NSConcreteMutableAttributedString
 
 initWithAttributedString: 参数传nil，不会造成闪退
 */
@implementation NSMutableAttributedString (Safe)

+ (void)startSafeMutableAttributedStringProtector {
    if ([[SafeClsCluster sharedInstance].switchManager getSafeMutableAttributedStringSwitchStatus]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class attrM = NSClassFromString(@"NSConcreteMutableAttributedString");
            
            // initWithString:
            SEL initWithStrSel = NSSelectorFromString(@"initWithString:");
            SEL safeInitWithStrSel = NSSelectorFromString(@"safe_initWithString:");
            [NSObject exchangeInstanceMethodWithCls:attrM originalSel:initWithStrSel swizzleSel:safeInitWithStrSel];
            
            // initWithString:attributes:
            SEL initWithStrAttributesSel = NSSelectorFromString(@"initWithString:attributes:");
            SEL safeInitWithStrAttributesSel = NSSelectorFromString(@"safe_initWithString:attributes:");
            [NSObject exchangeInstanceMethodWithCls:attrM originalSel:initWithStrAttributesSel swizzleSel:safeInitWithStrAttributesSel];
            
            // ----------------------- 增 -------------------------
            // appendAttributedString:
            SEL appendAttrStrSel = NSSelectorFromString(@"appendAttributedString:");
            SEL safeAppendAttrStrSel = NSSelectorFromString(@"safe_appendAttributedString:");
            [NSObject exchangeInstanceMethodWithCls:attrM originalSel:appendAttrStrSel swizzleSel:safeAppendAttrStrSel];
            
            // insertAttributedString:atIndex:
            SEL insertAttrStrAtIndexSel = NSSelectorFromString(@"insertAttributedString:atIndex:");
            SEL safeInsertAttrStrAtIndexSel = NSSelectorFromString(@"safe_insertAttributedString:atIndex:");
            [NSObject exchangeInstanceMethodWithCls:attrM originalSel:insertAttrStrAtIndexSel swizzleSel:safeInsertAttrStrAtIndexSel];
            
            // ----------------------- 删 -------------------------
            // deleteCharactersInRange:
            SEL deleteCharInRangeSel = NSSelectorFromString(@"deleteCharactersInRange:");
            SEL safeDeleteCharInRangeSel = NSSelectorFromString(@"safe_deleteCharactersInRange:");
            [NSObject exchangeInstanceMethodWithCls:attrM originalSel:deleteCharInRangeSel swizzleSel:safeDeleteCharInRangeSel];
            
            // ----------------------- 改 -------------------------
            // replaceCharactersInRange:withString:
            SEL replaceCharInRangeWithStrSel = NSSelectorFromString(@"replaceCharactersInRange:withString:");
            SEL safeReplaceCharInRangeWithStrSel = NSSelectorFromString(@"safe_replaceCharactersInRange:withString:");
            [NSObject exchangeInstanceMethodWithCls:attrM originalSel:replaceCharInRangeWithStrSel swizzleSel:safeReplaceCharInRangeWithStrSel];
            
            // replaceCharactersInRange:withAttributedString:
            SEL replaceCharInRangeWithAttrStrSel = NSSelectorFromString(@"replaceCharactersInRange:withAttributedString:");
            SEL safeReplaceCharInRangeWithAttrStrSel = NSSelectorFromString(@"safe_replaceCharactersInRange:withAttributedString:");
            [NSObject exchangeInstanceMethodWithCls:attrM originalSel:replaceCharInRangeWithAttrStrSel swizzleSel:safeReplaceCharInRangeWithAttrStrSel];
        });
    }
}

+ (void)load {
    
}

- (instancetype)safe_initWithString:(NSString *)str {
    if (!str) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSConcreteMutableAttributedString initWithString:]: nil value" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_initWithString:str];
}

- (instancetype)safe_initWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey, id> *)attrs {
    if (!str) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSConcreteMutableAttributedString initWithString:attributes:]: nil value" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return nil;
    }
    return [self safe_initWithString:str attributes:attrs];
}

// ----------------------- 增 -------------------------
- (void)safe_appendAttributedString:(NSAttributedString *)attrString {
    if (!attrString) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSConcreteMutableAttributedString appendAttributedString:]: nil value" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_appendAttributedString:attrString];
}

- (void)safe_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc {
    if (!attrString) {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"*** -[NSConcreteMutableAttributedString insertAttributedString:atIndex:]: nil value" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (loc > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString insertAttributedString:atIndex:]: Out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_insertAttributedString:attrString atIndex:loc];
}

// ----------------------- 删 -------------------------
- (void)safe_deleteCharactersInRange:(NSRange)range {
    if (range.location > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString deleteCharactersInRange:]: location out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (range.length > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString deleteCharactersInRange:]: length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if ((range.location + range.length) > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString deleteCharactersInRange:]: location and length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_deleteCharactersInRange:range];
}

// ----------------------- 改 -------------------------
- (void)safe_replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    if (!str) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString replaceCharactersInRange:withString:]: nil argument" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (range.location > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString replaceCharactersInRange:withString:]: location out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (range.length > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString replaceCharactersInRange:withString:]: length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if ((range.location + range.length) > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString replaceCharactersInRange:withString:]: location and length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_replaceCharactersInRange:range withString:str];
}

- (void)safe_replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString {
    if (!attrString) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString replaceCharactersInRange:withAttributedString:]: nil argument" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (range.location > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString replaceCharactersInRange:withAttributedString:]: location out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if (range.length > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString replaceCharactersInRange:withAttributedString:]: length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    if ((range.location + range.length) > self.string.length) {
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:@"*** -[NSConcreteMutableAttributedString replaceCharactersInRange:withAttributedString:]: location and length out of bounds" userInfo:nil];
        [[SafeClsCluster sharedInstance].exceptionManager dealException:exception];
        return;
    }
    [self safe_replaceCharactersInRange:range withAttributedString:attrString];
}

@end
