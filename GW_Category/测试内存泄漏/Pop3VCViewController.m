//
//  Pop3VCViewController.m
//  GW_Category
//
//  Created by zdwx on 2020/1/3.
//  Copyright © 2020 gw. All rights reserved.
//

#import "Pop3VCViewController.h"
#import "UIViewController+GWViewController.h"
static UIView *aaa = nil;
@interface Pop3VCViewController ()

@end

@implementation Pop3VCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    aaa = [UIView new];
    [self.view addSubview:aaa];
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

    UINavigationController *popNav3 = [[UINavigationController alloc] initWithRootViewController:pop3];
    [self presentViewController:popNav3 animated:YES completion:nil];
////        [self.navigationController pushViewController:pop2 animated:YES];
}

- (void)btn2Action{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self gw_dismissToRootViewControllerAnimated:YES];
}





- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.gw_isDidDisappearAndDeallocVC) {
        NSLog(@"Pop3VCViewController - disappear");
    }
}

- (void)dealloc{
    NSLog(@"Pop3VCViewController - dealloc");
}

@end
