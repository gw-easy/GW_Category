//
//  NSObject+GWObject.h
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define GW_MemoryLeakDebug 1
#endif

static const void * _Nonnull gw_sendAction_sender_LastKey = &gw_sendAction_sender_LastKey;
static const void * _Nonnull gw_splitVC_HasPop_key = &gw_splitVC_HasPop_key;
static const void * _Nonnull gw_Objc_Ptrs_key = &gw_Objc_Ptrs_key;
static const void * _Nonnull gw_viewStack_key = &gw_viewStack_key;
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GWObject)

#pragma mark - 方法交换
/// 交换自身对象方法
/// @param originalSelector 原始方法
/// @param swizzledSelector 交换方法
+ (void)exchangeInstanceOriginalSelector_GW:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;

/// 交换对象方法
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


#if GW_MemoryLeakDebug
@interface NSObject (GWObject_MemoryLeak)

/// 将要销毁
- (BOOL)GW_Dealloc;

/// 主动检测具体对象是否释放
- (void)GW_ReleaseObject;

/// 单个释放
/// @param child vc
- (void)GW_ReleaseChild:(id)child;

/// 多个释放
/// @param children VCs
- (void)GW_ReleaseChildren:(NSArray *)children;

//添加忽略白名单
+ (void)GW_addClassNamesToWhitelist:(NSArray *)classNames;
@end
#endif

NS_ASSUME_NONNULL_END
