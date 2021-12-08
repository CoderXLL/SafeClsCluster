# SafeClsCluster - OC类簇防崩保护组件

[![](https://img.shields.io/badge/language-ObjC-green)]()
[![](https://img.shields.io/badge/release-V1.0.0-blue)](https://github.com/b593771943/SafeClsCluster/tree/release/1.0.0)
[![](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-orange)]()
[![](https://img.shields.io/badge/License-MIT-orange)]()
[![](https://img.shields.io/badge/star-0-lightgrey)]()

**SafeClsCluster**是一款针对OC类簇安全保护的组件。可以保护的类簇有`NSArray`、`NSMutableArray`、`NSDictionary`、`NSMutableDictionary`、`NSString`、`NSMutableString`、`NSAttributedString`、`NSMutableAttributedString`、`NSSet`、`NSMutableSet`

## NSArray

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

## NSMutableArray

>  NSMutableArray类簇，其alloc后同样会优先产出一个中间对象**__NSPlacehodlerArray**

**__NSArrayM：**
实践说明`removeObjectAtIndex:`内部最终调用了`removeObjectsInRange:`方法。但是为了溯源造成crash的真正方法，对两个方法都进行了hook

## NSDictionary

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

## NSMutableDictionary

> -其alloc后会优先产出一个中间对象**__NSPlaceholderDictionary**

**__NSDictionaryM**
**setValue:forKey:**隶属于**NSObject(NSKeyValueCoding)**，经实践其内部会调用**setObject:forKey:**。组件对两个方法都进行了hook，方便溯源造成crash的真正方法

## NSString

> 其alloc后会优先产出一个中间对象NSPlaceholderString

 **__NSCFConstantString：**
静态的**__NSCFString**，通过@""、[NSString new]、@"xxx"初始化的NSString。其引用计数很大，所以其创建后是不会被释放的对象。其大部分实例方法都调用了__NSCFString的对应方法
 
 **NSTaggedPointerString：**
 在运行时通过stringWithFormat:创建出来的短字符串，是苹果的一种优化手段，将较小的对象直接放在了空余的指针地址中。这货引用计数也很大也是不可被释放
 
 **__NSCFString：**
 在运行时通过`stringWithFormat:`创建出来的长字符串或者可变字符串

## NSMutableString
**__NSCFString**

## NSAttributedString

>  - alloc和init后，只会产出一种实际的类对象**NSConcreteAttributedString**
> - 无论是`initWithAttributedString:`还是`initWithString:attributes:`，内部都会调用`initWithString:`。而造成闪退的基本也是这个方法传参为nil导致
 所以hook `initWithString:`就可以避免闪退。但是为了精确追踪，对以上每个函数都进行了hook

## NSMutableAttributedString
> - 同样只会产出一种实际的类对象**NSConcreteMutableAttributedString**
> -  其`initWithAttributedString: `参数传nil，并不会造成闪退

## NSSet

> 其alloc后会优先产出一个中间对象**__NSPlaceholderSet**
> 其所有的实例方法都可以直接通过NSSet类对象进行hook，不用hook其实际的类对象***（目前不清楚苹果这样设计的原因是什么）***

**__NSSingleObjectSetI：**
initWithObjects:、initWithArray:初始化，且只有一个成员的NSSet
 
**__NSSetI：**
有0个或1个以上成员的NSSet

## NSMutableSet

> 其alloc后会优先产出一个中间对象**__NSPlaceholderSet**

**__NSSetM：**
