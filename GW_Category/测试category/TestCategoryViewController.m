//
//  TestCategoryViewController.m
//  GW_Category
//
//  Created by gw on 2020/3/27.
//  Copyright © 2020 gw. All rights reserved.
//

#import "TestCategoryViewController.h"
#import "NSString+GWString.h"
@interface TestCategoryViewController ()

@end

@implementation TestCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testReplaceStr];
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
