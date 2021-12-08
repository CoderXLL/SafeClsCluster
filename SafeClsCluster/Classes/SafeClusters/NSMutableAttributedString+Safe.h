//
//  NSMutableAttributedString+Safe.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (Safe)

+ (void)startSafeMutableAttributedStringProtector;

@end

NS_ASSUME_NONNULL_END
