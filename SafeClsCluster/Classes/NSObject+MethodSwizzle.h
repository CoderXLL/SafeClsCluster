//
//  NSObject+MethodSwizzle.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MethodSwizzle)

+ (void)exchangeInstanceMethodWithCls:(Class)cls
                          originalSel:(SEL)originalSel
                           swizzleSel:(SEL)swizzleSel;

+ (void)exchangeClassMethodWithCls:(Class)cls
                       originalSel:(SEL)originalSel
                        swizzleSel:(SEL)swizzleSel;

@end

NS_ASSUME_NONNULL_END
