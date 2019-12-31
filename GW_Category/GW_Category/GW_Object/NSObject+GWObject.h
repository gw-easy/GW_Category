//
//  NSObject+GWObject.h
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GWObject)


#pragma mark - 方法交换
/// 交换自身对象方法
/// @param selfClass 类
/// @param originalSelector 原始方法
/// @param swizzledSelector 交换方法
+ (void)exchangeInstanceMethod_GW:(Class)selfClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 *  两个实例对象-交换两个函数指针  参数均为NSString类型
 *
 *  @param systemMethodSel 系统方法
 *  @param systemClass  系统实现方法类
 *  @param exchangeMethodSel   自定义hook方法
 *  @param exchangeClass  目标实现类
 */
+ (void)methodSwizzling_GW:(SEL)systemMethodSel systemClass:(Class)systemClass exchangeMethodSel:(SEL)exchangeMethodSel exchangeClass:(Class)exchangeClass;

@end

NS_ASSUME_NONNULL_END
