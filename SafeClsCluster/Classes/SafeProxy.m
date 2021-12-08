//
//  SafeProxy.m
//  ContainerCrash
//
//  Created by 肖乐乐 on 2021/12/7.
//

#import "SafeProxy.h"

@interface SafeProxy ()

@property (nonatomic, weak) id target;

@end

@implementation SafeProxy

+ (instancetype)proxyWithTarget:(id)target
{
    return [[SafeProxy alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target
{
    _target = target;
    return self;
}

#pragma mark - msg forwarding
- (id)forwardingTargetForSelector:(SEL)selector
{
    if (_target && [self respondsToSelector:selector]) {
        return _target;
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [_target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object
{
    return [_target isEqual:object];
}


- (NSUInteger)hash
{
    return [_target hash];
}

- (Class)superclass
{
    return [_target superclass];
}

- (Class)class
{
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass
{
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy
{
    return YES;
}

- (NSString *)description
{
    return [_target description];
}

- (NSString *)debugDescription
{
    return [_target debugDescription];
}

@end
