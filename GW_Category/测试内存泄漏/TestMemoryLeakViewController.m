//
//  ViewController.m
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//

#import "TestMemoryLeakViewController.h"
#import "PopTestVC.h"
@interface TestMemoryLeakViewController ()

@end

@implementation TestMemoryLeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

#pragma mark - UI
- (void)setUI{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(10, 200, 200, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction{
    PopTestVC *popVC = [PopTestVC new];
    UINavigationController *popNav = [[UINavigationController alloc] initWithRootViewController:popVC];
    [self presentViewController:popNav animated:YES completion:nil];
//    [self.navigationController pushViewController:popVC animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

@end
