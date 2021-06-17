//
//  TestModel.m
//  GW_Category
//
//  Created by gw on 2020/4/5.
//  Copyright © 2020 gw. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel
GW_CodingImplementation
+ (NSDictionary<NSString *,Class> *)GW_ModelDelegateReplacePropertyMapper{
    return @{@"testDic":[TestModel class],
             @"TestDic":[TestModel class],
             @"testArr":[TestModel class]
    };
}


@end
