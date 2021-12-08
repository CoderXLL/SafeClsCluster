//
//  NSMutableArray+Safe.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Safe)

+ (void)startSafeMutableArrayProtector;

@end

NS_ASSUME_NONNULL_END
