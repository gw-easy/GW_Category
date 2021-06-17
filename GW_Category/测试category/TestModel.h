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

@interface TestModelFive : NSObject
@property (copy, nonatomic) NSString *six;
@property (copy, nonatomic) NSString *seven;
@property (strong, nonatomic) NSMutableArray<TestModelFive *> *testArr;

@end

@interface TestModelFour : TestModelFive
@property (copy, nonatomic) NSString *four;
@property (copy, nonatomic) NSString *five;
//@property (strong, nonatomic) NSMutableArray<TestModelFour *> *testArr;

@end

@interface TestModelThree : TestModelFour
@property (copy, nonatomic) NSString *first;
@property (copy, nonatomic) NSNumber *secend;
@property (assign, nonatomic) BOOL three;
@property (assign, nonatomic) int testNum;

@end

@interface TestModelTwo : NSObject
@property (strong, nonatomic) TestModelThree *testDic;
@property (copy, nonatomic) NSString *first;
@property (copy, nonatomic) NSNumber *secend;
@property (assign, nonatomic) BOOL three;
@property (assign, nonatomic) int testNum;

@property (strong, nonatomic) NSMutableArray<TestModelThree *> *testArr;

@end

@interface TestModel : NSObject
@property (strong, nonatomic) TestModel *testDic;
@property (copy, nonatomic) NSString *first;
@property (copy, nonatomic) NSNumber *secend;
@property (assign, nonatomic) BOOL three;
@property (assign, nonatomic) int testNum;

@property (strong, nonatomic) NSMutableArray<TestModelTwo *> *testArr;

@end



NS_ASSUME_NONNULL_END
