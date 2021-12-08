//
//  SafeProxy.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
