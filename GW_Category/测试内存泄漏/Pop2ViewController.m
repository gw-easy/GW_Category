//
//  Pop2ViewController.m
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//

#import "Pop2ViewController.h"
#import "TestView.h"
#import "Pop3VCViewController.h"
#import "UIViewController+GWViewController.h"
@interface Pop2ViewController ()

@end

@implementation Pop2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview: [TestView alertV]];
    
    [self setUI];
}

#pragma mark - UI
- (void)setUI{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(10, 200, 200, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"join" forState:UIControlStateNormal];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn2];
    btn2.frame = CGRectMake(10, 400, 200, 30);
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"back" forState:UIControlStateNormal];
}

- (void)btnAction{
    Pop3VCViewController *pop3 = [Pop3VCViewController new];

    UINavigationController *popNav2 = [[UINavigationController alloc] initWithRootViewController:pop3];
    [self presentViewController:popNav2 animated:YES completion:nil];
//    [self.navigationController pushViewController:pop3 animated:YES];
}

- (void)btn2Action{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    
//    NSLog(@"viewWillDisappear");//}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.gw_isDidDisappearAndDeallocVC) {
        NSLog(@"Pop2ViewController - disappear");
    }
}

- (void)dealloc{
    NSLog(@"Pop2ViewController - dealloc");
}

@end
