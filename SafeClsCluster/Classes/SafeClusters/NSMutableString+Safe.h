//
//  NSMutableString+Safe.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (Safe)

+ (void)startSafeMutableStringProtector;

@end

NS_ASSUME_NONNULL_END
