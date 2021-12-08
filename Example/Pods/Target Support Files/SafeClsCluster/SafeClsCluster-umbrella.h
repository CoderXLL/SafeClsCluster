#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+MethodSwizzle.h"
#import "SafeClsCluster.h"
#import "NSArray+Safe.h"
#import "NSAttributedString+Safe.h"
#import "NSDictionary+Safe.h"
#import "NSMutableArray+Safe.h"
#import "NSMutableAttributedString+Safe.h"
#import "NSMutableDictionary+Safe.h"
#import "NSMutableSet+Safe.h"
#import "NSMutableString+Safe.h"
#import "NSSet+Safe.h"
#import "NSString+Safe.h"
#import "SafeExceptionManager.h"
#import "SafeProxy.h"
#import "SafeSwitchManager.h"

FOUNDATION_EXPORT double SafeClsClusterVersionNumber;
FOUNDATION_EXPORT const unsigned char SafeClsClusterVersionString[];

