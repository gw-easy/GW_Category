//
//  TestModel.h
//  GW_Category
//
//  Created by gw on 2020/4/5.
//  Copyright © 2020 gw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GW_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface TestModel : NSObject<NSCopying>
//@property (strong, nonatomic) TestModel *testDic;
@property (strong, nonatomic) TestModel *TestDic;
@property (copy, nonatomic) NSString *first;
//@property (copy, nonatomic) NSString *First;
@property (copy, nonatomic) NSString *secend;
@property (copy, nonatomic) NSString *three;
@property (assign, nonatomic) int testNum;

@property (strong, nonatomic) NSMutableArray<TestModel *> *testArr;


@end

NS_ASSUME_NONNULL_END
