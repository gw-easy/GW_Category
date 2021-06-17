//
//  TestModel.m
//  GW_Category
//
//  Created by gw on 2020/4/5.
//  Copyright © 2020 gw. All rights reserved.
//

#import "TestModel.h"

@implementation TestModelFive

GW_CodingImplementation
+ (NSDictionary<NSString *,Class> *)GW_ModelDelegateReplacePropertyMapper{
    return @{
             @"testArr":[TestModelFive class]
    };
}

@end

@implementation TestModelFour
GW_CodingImplementation
//+ (NSDictionary<NSString *,Class> *)GW_ModelDelegateReplacePropertyMapper{
//    return @{
//             @"testArr":[TestModelFour class]
//    };
//}

@end

@implementation TestModelThree
GW_CodingImplementation

@end


@implementation TestModelTwo
GW_CodingImplementation
+ (NSDictionary<NSString *,Class> *)GW_ModelDelegateReplacePropertyMapper{
    return @{@"testDic":[TestModelThree class],
             @"testArr":[TestModelThree class]
    };
}

@end

@implementation TestModel
GW_CodingImplementation
+ (NSDictionary<NSString *,Class> *)GW_ModelDelegateReplacePropertyMapper{
    return @{@"testDic":[TestModel class],
             @"testArr":[TestModelTwo class]
    };
}


@end
