# SafeClsCluster - OC类簇防崩保护组件

[![](https://img.shields.io/badge/language-ObjC-green)]()
[![](https://img.shields.io/badge/release-V1.0.0-blue)](https://github.com/b593771943/SafeClsCluster/tree/release/1.0.0)
[![](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-orange)]()
[![](https://img.shields.io/badge/License-MIT-orange)]()
[![](https://img.shields.io/badge/star-0-lightgrey)]()
[![](https://img.shields.io/badge/support%20cluster-NSArray%20%7C%20NSMutableArray%20%7C%20NSDictionary%20%7C%20NSMutableDictionary%20%7C%20NSString%20%7C%20NSMutableString%20%7C%20NSAttributedString%20%7C%20NSMutableAttributedString%20%7C%20NSSet%20%7C%20NSMutableSet-red)]()

**SafeClsCluster**是一款针对OC类簇安全保护的组件。可以保护的类簇有`NSArray`、`NSMutableArray`、`NSDictionary`、`NSMutableDictionary`、`NSString`、`NSMutableString`、`NSAttributedString`、`NSMutableAttributedString`、`NSSet`、`NSMutableSet`

### 使用方法
- 一键开启组件支持的所有类簇安全保护
```
[[SafeClsCluster sharedInstance].switchManager openAllSafeSwitch];
```
- 设置DEBUG模式针对类簇Crash异常的处理方式
```
typedef NS_ENUM(NSInteger, ExceptionDebugDealWay) {
    ExceptionDebugDealWayNone, // 不做处理
    ExceptionDebugDealWayLog,  // 打印异常
    ExceptionDebugDealWayThrow // 抛出异常
};

[[SafeClsCluster sharedInstance].exceptionManager setupExceptionDebugDealWay:ExceptionDebugDealWayLog];
```
- 自定义部分类簇进行开启安全保护
```
[[SafeClsCluster sharedInstance].switchManager setupSafeArraySwitch:YES];
[[SafeClsCluster sharedInstance].switchManager setupSafeSetSwitch:YES];
...
```
### 源码说明
##### SafeExceptionManager
捕获的类簇Crash异常管理协议
```
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
```

##### SafeSwitchManager
类簇安全保护开关管理协议
```
@protocol SafeSwitchManager <NSObject>

@required
/// 一键开启所有类簇安全保护
- (void)openAllSafeSwitch;

/// 是否对NSArray类簇开启安全保护
/// @param isOpen 是否开启
/// @discussion 一键开启后，再进行此设置无效
- (void)setupSafeArraySwitch:(BOOL)isOpen;
...

@optional
/// 获取NSArray类簇安全保护状态
- (BOOL)getSafeArraySwitchStatus;
...
```
##### 类簇保护开关状态
利用``共用体``节省内存存储空间，因为超过8个状态，所以使用``short``类型（2个字节）的存储空间进行存储10个状态值
```
#define SafeArrSwitchMask   (1 << 0)
#define SafeArrMSwitchMask  (1 << 1)
#define SafeDictSwitchMask  (1 << 2)
#define SafeDictMSwitchMask (1 << 3)
#define SafeStrSwitchMask   (1 << 4)
#define SafeStrMSwitchMask  (1 << 5)
#define SafeAttrSwitchMask  (1 << 6)
#define SafeAttrMSwitchMask (1 << 7)
#define SafeSetSwitchMask   (1 << 8)
#define SafeSetMSwtichMask  (1 << 9)

union {
        short bits; // 超过8位，需要2个字节的空间
        struct {
            char arr_switch   : 1;
            char arrM_switch  : 1;
            char dict_switch  : 1;
            char dictM_switch : 1;
            char str_switch   : 1;
            char strM_switch  : 1;
            char attr_swtich  : 1;
            char attrM_swtich : 1;
            char set_switch   : 1;
            char setM_switch  : 1;
        };
    } _switchStatus;

// 存值
- (void)setupSafeArraySwitch:(BOOL)isOpen {
    if (isOpen) {
        _switchStatus.bits |= SafeArrSwitchMask;
        [NSArray startSafeArrayProtector];
    } else {
        _switchStatus.bits &= ~SafeArrSwitchMask;
    }
}

// 取值
- (BOOL)getSafeArraySwitchStatus {
    return !!(_switchStatus.bits & SafeArrSwitchMask);
}
```
### 组件支持类簇说明
##### NSArray

>  NSArray类簇，运用工厂模式初始化后分别有根据情况生产出不同的类对象。 其alloc后会优先产出一个中间对象**__NSPlacehodlerArray**

**__NSArray0：**
 - @[]、[[NSArray alloc] init]、[NSArray new]、[NSArray arrayWithObjects:nil, nil] 即没有成员的NSArray
 - 其两种访问成员方式 array[4]、[array objectAtIndex:4] 都是触发`objectAtIndex:`方法
 
 **__NSSingleObjectArrayI：**
 - [NSArray arrayWithObjects:@"哈哈", nil]、[NSArray arrayWithObject:@"haha"] 通过arrayWithObjects初始化，且只有一个成员的NSArray
 - 其两种访问成员方式 array[4]、[array objectAtIndex:4] 都是触发`objectAtIndex:`方法
 
 **__NSArrayI：**
 - [[NSArray alloc] initWithObjects:@"lala", @"haha", nil] 通过arrayWithObjects初始化、且有一个以上成员的NSArray
 - 其访问成员方式 array[4] 触发`objectAtIndexedSubscript:`方法、[array objectAtIndex:4] 触发`objectAtIndex:`方法
 
 **NSConstantArray：**
 - @[@"lala", @"haha"] 通过中括号方式初始化，一个即以上成员的NSArray
 - 其访问成员方式 array[4] 触发`objectAtIndexedSubscript:`方法、[array objectAtIndex:4] 触发`objectAtIndex:`方法

##### NSMutableArray

>  NSMutableArray类簇，其alloc后同样会优先产出一个中间对象**__NSPlacehodlerArray**

**__NSArrayM：**
实践说明`removeObjectAtIndex:`内部最终调用了`removeObjectsInRange:`方法。但是为了溯源造成crash的真正方法，对两个方法都进行了hook

##### NSDictionary

 > - 其alloc后会优先产出一个中间对象**__NSPlaceholderDictionary**
> - 字典的key为nil、Nil、NULL、[NSNull null]都不会造成crash，所以组件中没有hook其任何的取值方法
> - **setValue:forUndefinedKey:**方法隶属于**NSObject(NSKeyValueCoding)**，将NSDictionary不小心当做NSMutableDictionary使用去设置会造成此方法相关的crash，所以对此也做了hook保护

 **__NSDictionary0：**
 
 @{}、、[[NSDictionary alloc] init]、[NSDictionary new] 即没有键值对的NSDictionary
 
**__NSSingleEntryDictionaryI：**

 不使用大括号直接初始化，且只有一个键值对的NSDictionary
 
**__NSDictionaryI：**
 
 不使用大括号直接初始化，有一个以上键值对的NSDictionary
 
 **NSConstantDictionary：**
 
 通过大括号方式初始化，一个即以上成员的NSDictionary

##### NSMutableDictionary

> -其alloc后会优先产出一个中间对象**__NSPlaceholderDictionary**

**__NSDictionaryM**

**setValue:forKey:**隶属于**NSObject(NSKeyValueCoding)**，经实践其内部会调用**setObject:forKey:**。组件对两个方法都进行了hook，方便溯源造成crash的真正方法

##### NSString

> 其alloc后会优先产出一个中间对象NSPlaceholderString

 **__NSCFConstantString：**

静态的**__NSCFString**，通过@""、[NSString new]、@"xxx"初始化的NSString。其引用计数很大，所以其创建后是不会被释放的对象。其大部分实例方法都调用了__NSCFString的对应方法
 
 **NSTaggedPointerString：**
 
 在运行时通过**stringWithFormat:**创建出来的短字符串，是苹果的一种优化手段，将较小的对象直接放在了空余的指针地址中。这货引用计数也很大也是不可被释放
 
 **__NSCFString：**
 
 在运行时通过`stringWithFormat:`创建出来的长字符串或者可变字符串

##### NSMutableString
**__NSCFString**

##### NSAttributedString

>  - alloc和init后，只会产出一种实际的类对象**NSConcreteAttributedString**
> - 无论是`initWithAttributedString:`还是`initWithString:attributes:`，内部都会调用`initWithString:`。而造成闪退的基本也是这个方法传参为nil导致
 所以hook `initWithString:`就可以避免闪退。但是为了精确追踪，对以上每个函数都进行了hook

##### NSMutableAttributedString

> - 同样只会产出一种实际的类对象**NSConcreteMutableAttributedString**
> -  其`initWithAttributedString: `参数传nil，并不会造成闪退

##### NSSet

> 其alloc后会优先产出一个中间对象**__NSPlaceholderSet**
> 其所有的实例方法都可以直接通过NSSet类对象进行hook，不用hook其实际的类对象***（目前不清楚苹果这样设计的原因是什么）***

**__NSSingleObjectSetI：**

initWithObjects:、initWithArray:初始化，且只有一个成员的NSSet
 
**__NSSetI：**

有0个或1个以上成员的NSSet

##### NSMutableSet

> 其alloc后会优先产出一个中间对象**__NSPlaceholderSet**

**__NSSetM：**

