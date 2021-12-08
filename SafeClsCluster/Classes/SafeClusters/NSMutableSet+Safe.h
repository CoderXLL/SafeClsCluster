//
//  NSMutableSet+Safe.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableSet (Safe)

+ (void)startSafeMutableSetProtector;

@end

NS_ASSUME_NONNULL_END
