//
//  PopTestVC.m
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//

#import "PopTestVC.h"
#import "Pop2ViewController.h"
//static UIView *aaa = nil;
@interface PopTestVC ()

@end

@implementation PopTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
//    aaa = [UIView new];
//    [self.view addSubview:aaa];
    
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
    Pop2ViewController *pop2 = [Pop2ViewController new];

//    UINavigationController *popNav2 = [[UINavigationController alloc] initWithRootViewController:pop2];
//    [self presentViewController:pop2 animated:YES completion:nil];
    [self.navigationController pushViewController:pop2 animated:YES];
}

- (void)btn2Action{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.gw_isDidDisappearAndDeallocVC) {
        
        NSLog(@"PopTestVC - disappear");
    }
}

- (void)dealloc{
    NSLog(@"PopTestVC - dealloc");
}

@end
