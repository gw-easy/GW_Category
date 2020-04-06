//
//  NSObject+GW_Model.h
//  gw_test
//
//  Created by gw on 2018/3/29.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 支持多继承copy父类

#define GW_CodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self GW_Decode:decoder rootObj:self]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self GW_Encode:encoder rootObj:self]; \
}\
- (id)copyWithZone:(NSZone *)zone { return [self GW_Copy:self]; }

@protocol GW_Model_ChangeDelegate <NSObject>
@optional
// 可自定义类<替换实际属性名,实际类>
+ (NSDictionary <NSString *, Class> *)GW_ModelDelegateReplacePropertyMapper;
// 可替换属性名值<替换实际属性名,需要赋值的属性名>
+ (NSDictionary <NSString *, NSString *> *)GW_ModelDelegateReplacePropertyName;
//每一个json->model转换完成后的回调 obj返回的实例对象，可对自定义属性赋值
+ (void)GW_JsonToModelFinish:(NSObject *)Obj;
@end

@interface NSObject (GW_Model)<GW_Model_ChangeDelegate>

#pragma mark json->model - 使用注意事项
//1、需要保证属性名称和json里的参数名一致，或者实现（GW_ModelDelegateReplacePropertyValue 代理）。
//2、支持model传代继承，对于array／dictionary里包含的model类型，需要将model类名和参数名保持一致，或者实现（GW_ModelDelegateReplacePropertyMapper 代理），或者请用带changeDic参数的方法 changeDic大于代理等级。
//3、对于类中出现同名属性大小写的情况，此控件只会对大写属性赋值。

/**
 无路径转换，一个命令转换任何格式的json

 @param json json
 @return model
 */
+ (id)GW_JsonToModel:(id)json;

/**
 json->model

 @param json json
 @param keyPath 路径需要用“／”区分
 @return model
 */
+ (id)GW_JsonToModel:(id)json keyPath:(NSString *)keyPath;


/**
 json->model 自定义参数名，命名原则为--参数名：所改变类的类名（只针对数组／字典）

 @param json json
 @param keyPath 路径需要用“／”区分
 @param changeDic 优先级大于代理
 @return model
 */
+ (id)GW_JsonToModel:(id)json keyPath:(NSString *)keyPath changeDic:(NSDictionary<NSString *,Class> *)changeDic;

///////////////////////////////////////////////////////

#pragma mark model->json 支持深层递归 支持多继承 注意事项：model嵌套的model必须实例化，否则解析为null

/**
 model转json

 @param rootObj model本身
 @return json
 */
- (NSString *)GW_ModelToJson:(__kindof NSObject *)rootObj;


/**
 model转NSDictionary

 @param rootObj model本身
 @return NSDictionary
 */
- (NSDictionary *)GW_ModelToDictionary:(__kindof NSObject *)rootObj;


///////////////////////////////////////////////////////

#pragma mark 模型对象序列化 深层递归模型 支持多继承

/**
 model copy

 @param rootObj model本身
 @return model
 */
- (id)GW_Copy:(__kindof NSObject *)rootObj;


/**
 归档

 @param encode encode
 @param rootObj model本身
 */
- (void)GW_Encode:(NSCoder *)encode rootObj:(__kindof NSObject *)rootObj;


/**
 解档

 @param decode decode
 @param rootObj model本身
 */
- (void)GW_Decode:(NSCoder *)decode rootObj:(__kindof NSObject *)rootObj;
@end
