//
//  TestTimeDeallocViewController.m
//  GW_Category
//
//  Created by zdwx on 2020/1/3.
//  Copyright © 2020 gw. All rights reserved.
//

#import "TestTimeDeallocViewController.h"
#import "UIViewController+GWViewController.h"
#import "TwoTImeViewController.h"
@interface TestTimeDeallocViewController ()
@property (strong ,nonatomic) NSTimer *oneTime;
@end

@implementation TestTimeDeallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)btnAction{
    TwoTImeViewController *popVC = [TwoTImeViewController new];
    popVC.index = self.index+1;
//    UINavigationController *popNav = [[UINavigationController alloc] initWithRootViewController:popVC];
//    [self presentViewController:popNav animated:YES completion:nil];
    [self.navigationController pushViewController:popVC animated:YES];
}

- (void)btn2Action{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self gw_dismissToRootViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI
- (void)setUI{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(10, 200, 200, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:btn2];
//    btn2.frame = CGRectMake(10, 400, 200, 30);
//    btn2.backgroundColor = [UIColor greenColor];
//    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
//    [btn2 setTitle:@"back" forState:UIControlStateNormal];
    _oneTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_oneTime forMode:NSRunLoopCommonModes];
}

- (void)timeAction{
    NSLog(@"TestTimeDeallocViewController - go - %ld",(long)self.index);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.gw_isDidDisappearAndDeallocVC) {
        if (_oneTime) {
            [_oneTime invalidate];
            _oneTime = nil;
        }
    }
}

- (void)dealloc{
    NSLog(@"TestTimeDeallocViewController - dealloc");
}
@end
