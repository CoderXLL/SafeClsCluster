//
//  SafeExceptionManager.h
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ExceptionDebugDealWay) {
    ExceptionDebugDealWayNone, // 不做处理
    ExceptionDebugDealWayLog,  // 打印异常
    ExceptionDebugDealWayThrow // 抛出异常
};

@protocol SafeExceptionManager <NSObject>

@required

/// 设置debug时期异常处理方式
/// @param exceptionDealWay 异常处理方式
- (void)setupExceptionDebugDealWay:(ExceptionDebugDealWay)exceptionDealWay;

@optional
/// 处理异常
/// @param exception 捕获的异常
- (void)dealException:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
