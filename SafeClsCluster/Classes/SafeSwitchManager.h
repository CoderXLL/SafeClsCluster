//
//  SafeSwitchManager.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SafeSwitchManager <NSObject>

@required
/// 一键开启所有类簇安全保护
- (void)openAllSafeSwitch;

/// 是否对NSArray类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeArraySwitch:(BOOL)isOpen;

///  是否对NSMutableArray类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeMutableArraySwitch:(BOOL)isOpen;

///  是否对NSDictionary类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeDictionarySwitch:(BOOL)isOpen;

///  是否对NSMutableDictionary类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeMutableDictionarySwitch:(BOOL)isOpen;

///  是否对NSString类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeStringSwitch:(BOOL)isOpen;

///  是否对NSMutableString类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeMutableStringSwitch:(BOOL)isOpen;

///  是否对NSAttributedString类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeAttributedStringSwitch:(BOOL)isOpen;

///  是否对NSMutableAttributedString类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeMutableAttributedStringSwitch:(BOOL)isOpen;

/// 是否对NSSet类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeSetSwitch:(BOOL)isOpen;

/// 是否对NSMutableSet类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeMutableSetSwitch:(BOOL)isOpen;

@optional
/// 获取NSArray类簇安全保护状态
- (BOOL)getSafeArraySwitchStatus;

/// 获取NSMutableArray类簇安全保护状态
- (BOOL)getSafeMutableArraySwitchStatus;

/// 获取NSDictionary类簇安全保护状态
- (BOOL)getSafeDictionarySwitchStatus;

/// 获取NSMutableDictionary类簇安全保护状态
- (BOOL)getSafeMutableDictionarySwitchStatus;

/// 获取NSString类簇安全保护状态
- (BOOL)getSafeStringSwitchStatus;

/// 获取NSMutableArray类簇安全保护状态
- (BOOL)getSafeMutableStringSwitchStatus;

/// 获取NSAttributedString类簇安全保护状态
- (BOOL)getSafeAttributedStringSwitchStatus;

/// 获取NSMutableAttributedString类簇安全保护状态
- (BOOL)getSafeMutableAttributedStringSwitchStatus;

/// 获取NSSet类簇安全保护状态
- (BOOL)getSafeSetSwitchStatus;

/// 获取NSMutableSet类簇安全保护状态
- (BOOL)getSafeMutableSetSwitchStatus;

@end

NS_ASSUME_NONNULL_END
