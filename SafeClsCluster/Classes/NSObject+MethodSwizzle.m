//
//  NSObject+MethodSwizzle.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/1.
//

#import "NSObject+MethodSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (MethodSwizzle)

+ (void)exchangeInstanceMethodWithCls:(Class)cls
                          originalSel:(SEL)originalSel
                           swizzleSel:(SEL)swizzleSel {
    Method originMethod = class_getInstanceMethod(cls, originalSel);
    Method swizzleMethod = class_getInstanceMethod(cls, swizzleSel);
    BOOL didAddMethod = class_addMethod(cls, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzleSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

+ (void)exchangeClassMethodWithCls:(Class)cls
                       originalSel:(SEL)originalSel
                        swizzleSel:(SEL)swizzleSel {
    Method originMethod = class_getClassMethod(cls, originalSel);
    Method swizzleMethod = class_getClassMethod(cls, swizzleSel);
    BOOL didAddMethod = class_addMethod(object_getClass(cls), originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(object_getClass(cls), swizzleSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

@end
