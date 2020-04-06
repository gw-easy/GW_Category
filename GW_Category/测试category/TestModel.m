//
//  TestModel.m
//  GW_Category
//
//  Created by gw on 2020/4/5.
//  Copyright © 2020 gw. All rights reserved.
//

#import "TestModel.h"
#import "NSObject+GW_Model.h"
@implementation TestModel
+ (NSDictionary<NSString *,Class> *)GW_ModelDelegateReplacePropertyMapper{
    return @{@"testDic":[TestModel class],@"TestDic":[TestModel class]};
}
@end
