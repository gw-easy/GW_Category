//
//  TestCategoryViewController.m
//  GW_Category
//
//  Created by gw on 2020/3/27.
//  Copyright © 2020 gw. All rights reserved.
//

#import "TestCategoryViewController.h"
#import "NSString+GWString.h"

#import "TestModel.h"
@interface TestCategoryViewController ()

@end

@implementation TestCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self testReplaceStr];
    [self testModel];
}

- (void)testModel{
    NSMutableDictionary *testModelDict5 = [NSMutableDictionary dictionary];
    [testModelDict5 setValue:@"modelthree-six" forKey:@"six"];
    [testModelDict5 setValue:@"modelthree-seven" forKey:@"seven"];
    
    NSMutableDictionary *testModelDict3 = [NSMutableDictionary dictionary];
    [testModelDict3 setValue:@"modelthree" forKey:@"first"];
    [testModelDict3 setValue:@"modelthree-five" forKey:@"five"];
    [testModelDict3 setValue:@"modelthree-four" forKey:@"four"];
    [testModelDict3 setValue:@"modelthree-six" forKey:@"six"];
    [testModelDict3 setValue:@"modelthree-seven" forKey:@"seven"];
    [testModelDict3 setValue:@(333) forKey:@"secend"];
    [testModelDict3 setValue:@{@"secend":@(333)} forKey:@"testDic"];
    [testModelDict3 setValue:@[testModelDict5,testModelDict5] forKey:@"testArr"];

    
    NSMutableDictionary *testModelDict2 = [NSMutableDictionary dictionary];
    [testModelDict2 setValue:@"modeltwo" forKey:@"first"];
    [testModelDict2 setValue:@(222) forKey:@"secend"];
    [testModelDict2 setValue:@{@"secend":@(222)} forKey:@"testDic"];
    [testModelDict2 setValue:@[testModelDict3,testModelDict3] forKey:@"testArr"];

    
    NSMutableDictionary *testModelDict = [NSMutableDictionary dictionary];
    [testModelDict setValue:@"arr" forKey:@"first"];
    [testModelDict setValue:@(111) forKey:@"secend"];
    [testModelDict setValue:@{@"secend":@(111)} forKey:@"testDic"];
    [testModelDict setValue:@[testModelDict2,testModelDict2] forKey:@"testArr"];

    
    NSString *json = [testModelDict GW_ModelToJson:testModelDict];
    NSLog(@"json = %@",json);
    
    [self testJsonToModel:json];
//    [self testModelCopy:json];
}

- (void)testJsonToModel:(NSString *)json{
    TestModel *model = [TestModel GW_JsonToModel:json];
    [self printModelProperty:model];
}

- (void)testModelCopy:(NSString *)json{
    TestModel *model = [TestModel GW_JsonToModel:json];
    
    [self printModelAddress:model];
    
    TestModel *model2 = [model GW_Copy:model needDepth:YES];
    [self printModelAddress:model2];
}

-(void)printModelProperty:(TestModel *)model{
    NSLog(@"model --- model-first = %@,model-secend=%@,model-testDic=%@,model-testArr=%@",model.first,model.secend,model.testDic,model.testArr);
    for (TestModelTwo *twoModel in model.testArr) {
        NSLog(@"twoModel --- model-first = %@,model-secend=%@,model-testDic=%@,model-testArr=%@",twoModel.first,twoModel.secend,twoModel.testDic,twoModel.testArr);
        for (TestModelThree *threeModel in twoModel.testArr) {
            NSLog(@"threeModel --- model-first = %@,model-secend=%@,model-testArr=%@,model-four=%@,model-five=%@,model-six=%@,model-seven=%@",threeModel.first,threeModel.secend,threeModel.testArr,threeModel.four,threeModel.five,threeModel.six,threeModel.seven);
            for (TestModelFive *fiveModel in threeModel.testArr) {
                NSLog(@"fiveModel --- model-four=%@,model-five=%@",fiveModel.six,fiveModel.seven);

            }
        }

    }
}

- (void)printModelAddress:(TestModel *)model{
    NSLog(@"model = %@",model);
    for (TestModelTwo *twoModel in model.testArr) {
        NSLog(@"twoModel = %@",twoModel);
        for (TestModelThree *threeModel in twoModel.testArr) {
            NSLog(@"threeModel = %@",threeModel);
            for (TestModelFour *fourModel in threeModel.testArr) {
                NSLog(@"fourModel = %@",fourModel);

            }
        }
    }
}

- (void)testReplaceStr{
    UILabel *testL = [UILabel new];
    [self.view addSubview:testL];
    testL.frame = CGRectMake(10, 100, 100, 300);
    testL.numberOfLines = 0;
    testL.textColor = [UIColor blackColor];
    testL.attributedText = [@"您已购买的 一建考霸尊享班-建筑工程管理与实务 您已购买的 一建考霸尊享班-建筑工程管理与实务 您已购买的 一建考霸尊享班-建筑工程管理与实务 您已购买的 一建考霸尊享班-建筑工程管理与实务您已购买的 一建考霸尊享班-建筑工程管理与实务" gw_stringNeedReplaceString:@"一建考霸尊享班-建筑工程管理与实务" Font:nil textColor:[UIColor redColor]];
    
}

@end
