//
//  SafeContainer.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import <Foundation/Foundation.h>
#import "SafeExceptionManager.h"
#import "SafeSwitchManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SafeClsCluster : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong, readonly) id<SafeExceptionManager> exceptionManager;
@property (nonatomic, strong, readonly) id<SafeSwitchManager> switchManager;

@end

NS_ASSUME_NONNULL_END
