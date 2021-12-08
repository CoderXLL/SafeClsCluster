//
//  SafeClsCluster.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import "SafeClsCluster.h"
#import "SafeProxy.h"
#import "NSArray+Safe.h"
#import "NSMutableArray+Safe.h"
#import "NSDictionary+Safe.h"
#import "NSMutableDictionary+Safe.h"
#import "NSString+Safe.h"
#import "NSMutableString+Safe.h"
#import "NSAttributedString+Safe.h"
#import "NSMutableAttributedString+Safe.h"
#import "NSSet+Safe.h"
#import "NSMutableSet+Safe.h"

#define SafeArrSwitchMask   (1 << 0)
#define SafeArrMSwitchMask  (1 << 1)
#define SafeDictSwitchMask  (1 << 2)
#define SafeDictMSwitchMask (1 << 3)
#define SafeStrSwitchMask   (1 << 4)
#define SafeStrMSwitchMask  (1 << 5)
#define SafeAttrSwitchMask  (1 << 6)
#define SafeAttrMSwitchMask (1 << 7)
#define SafeSetSwitchMask   (1 << 8)
#define SafeSetMSwtichMask  (1 << 9)

@interface SafeClsCluster () <SafeExceptionManager, SafeSwitchManager>
{
    union {
        short bits; // 超过8位，需要2个字节的空间
        struct {
            char arr_switch   : 1;
            char arrM_switch  : 1;
            char dict_switch  : 1;
            char dictM_switch : 1;
            char str_switch   : 1;
            char strM_switch  : 1;
            char attr_swtich  : 1;
            char attrM_swtich : 1;
            char set_switch   : 1;
            char setM_switch  : 1;
        };
    } _switchStatus;
}

@property (nonatomic, assign) ExceptionDebugDealWay exceptionDealWay;

@property (nonatomic, strong, readwrite) id<SafeExceptionManager> exceptionManager;
@property (nonatomic, strong, readwrite) id<SafeSwitchManager> switchManager;

@end

@implementation SafeClsCluster
static SafeClsCluster *instance_ = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[[self class] alloc] init];
    });
    return instance_;
}

- (instancetype)init {
    if (self = [super init]) {
        self.exceptionManager = [SafeProxy proxyWithTarget:self];
        self.switchManager = [SafeProxy proxyWithTarget:self];
        self.exceptionDealWay = ExceptionDebugDealWayLog;
    }
    return self;
}

#pragma mark - SafeExceptionManager
- (void)setupExceptionDebugDealWay:(ExceptionDebugDealWay)exceptionDealWay {
    self.exceptionDealWay = exceptionDealWay;
}

- (void)dealException:(NSException *)exception {
    if (!exception) return;
#ifndef DEBUG
#else
    switch (self.exceptionDealWay) {
        case ExceptionDebugDealWayLog:
            NSLog(@"%@", exception);
            break;
        case ExceptionDebugDealWayThrow:
            @throw exception;
            break;
        case ExceptionDebugDealWayNone:
        default:
            break;
    }
#endif
}

#pragma mark - SafeSwitchManager
- (void)openAllSafeSwitch {
    [self setupSafeArraySwitch:YES];
    [self setupSafeMutableArraySwitch:YES];
    [self setupSafeDictionarySwitch:YES];
    [self setupSafeMutableDictionarySwitch:YES];
    [self setupSafeStringSwitch:YES];
    [self setupSafeMutableStringSwitch:YES];
    [self setupSafeAttributedStringSwitch:YES];
    [self setupSafeMutableAttributedStringSwitch:YES];
    [self setupSafeSetSwitch:YES];
    [self setupSafeMutableSetSwitch:YES];
}

- (void)setupSafeArraySwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeArrSwitchMask;
        [NSArray startSafeArrayProtector];
    } else {
        _switchStatus.bits &= ~SafeArrSwitchMask;
    }
}

- (void)setupSafeMutableArraySwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeArrMSwitchMask;
        [NSMutableArray startSafeMutableArrayProtector];
    } else {
        _switchStatus.bits &= ~SafeArrMSwitchMask;
    }
}

- (void)setupSafeDictionarySwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeDictSwitchMask;
        [NSDictionary startSafeDictionaryProtector];
    } else {
        _switchStatus.bits &= ~SafeDictSwitchMask;
    }
}

- (void)setupSafeMutableDictionarySwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeDictMSwitchMask;
        [NSMutableDictionary startSafeMutableDictionaryProtector];
    } else {
        _switchStatus.bits &= ~SafeDictMSwitchMask;
    }
}

- (void)setupSafeStringSwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeStrSwitchMask;
        [NSString startSafeStringProtector];
    } else {
        _switchStatus.bits &= ~SafeStrSwitchMask;
    }
}

- (void)setupSafeMutableStringSwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeStrMSwitchMask;
        [NSMutableString startSafeMutableStringProtector];
    } else {
        _switchStatus.bits &= ~SafeStrMSwitchMask;
    }
}

- (void)setupSafeAttributedStringSwitch:(BOOL)isOpen { 
    if (isOpen) {
        _switchStatus.bits |= SafeAttrSwitchMask;
        [NSAttributedString startSafeAttributedStringProtector];
    } else {
        _switchStatus.bits &= ~SafeAttrSwitchMask;
    }
}

- (void)setupSafeMutableAttributedStringSwitch:(BOOL)isOpen { 
    if (isOpen) {
        _switchStatus.bits |= SafeAttrMSwitchMask;
        [NSMutableAttributedString startSafeMutableAttributedStringProtector];
    } else {
        _switchStatus.bits &= ~SafeAttrMSwitchMask;
    }
}

- (void)setupSafeSetSwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeSetSwitchMask;
        [NSSet startSafeSetProtector];
    } else {
        _switchStatus.bits &= ~SafeSetSwitchMask;
    }
}

- (void)setupSafeMutableSetSwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeSetMSwtichMask;
        [NSMutableSet startSafeMutableSetProtector];
    } else {
        _switchStatus.bits &= ~SafeSetMSwtichMask;
    }
}

- (BOOL)getSafeArraySwitchStatus {
    return !!(_switchStatus.bits & SafeArrSwitchMask);
}

- (BOOL)getSafeMutableArraySwitchStatus {
    return !!(_switchStatus.bits & SafeArrMSwitchMask);
}

- (BOOL)getSafeDictionarySwitchStatus {
    return !!(_switchStatus.bits & SafeDictSwitchMask);
}

- (BOOL)getSafeMutableDictionarySwitchStatus {
    return !!(_switchStatus.bits & SafeDictMSwitchMask);
}

- (BOOL)getSafeStringSwitchStatus {
    return !!(_switchStatus.bits & SafeStrSwitchMask);
}

- (BOOL)getSafeMutableStringSwitchStatus {
    return !!(_switchStatus.bits & SafeStrMSwitchMask);
}

- (BOOL)getSafeAttributedStringSwitchStatus {
    return !!(_switchStatus.bits & SafeAttrSwitchMask);
}

- (BOOL)getSafeMutableAttributedStringSwitchStatus {
    return !!(_switchStatus.bits & SafeAttrMSwitchMask);
}

- (BOOL)getSafeSetSwitchStatus {
    return !!(_switchStatus.bits & SafeSetSwitchMask);
}

- (BOOL)getSafeMutableSetSwitchStatus {
    return !!(_switchStatus.bits & SafeSetMSwtichMask);
}

@end

