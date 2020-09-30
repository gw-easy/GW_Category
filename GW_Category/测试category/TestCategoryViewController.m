//
//  TestCategoryViewController.m
//  GW_Category
//
//  Created by gw on 2020/3/27.
//  Copyright © 2020 gw. All rights reserved.
//

#import "TestCategoryViewController.h"
#import "NSString+GWString.h"
#import "NSObject+GW_Model.h"
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
    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
//    [muDict setValue:@"222" forKey:@"first"];
    [muDict setValue:@"666" forKey:@"First"];
//    [muDict setValue:@"222" forKey:@"first"];
//    [muDict setValue:@{@"First":@"333"} forKey:@"testDic"];
    [muDict setValue:@{@"First":@"111"} forKey:@"TestDic"];
    [muDict setValue:@{@"First":@"333"} forKey:@"testDic"];
    TestModel *model = [TestModel GW_JsonToModel:[muDict GW_ModelToJson:muDict]];

    NSLog(@"%@---%@-----%@",model.First,model.first,model.TestDic.First);
//        NSLog(@"%@---%@",model.First,model.TestDic.First);

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
