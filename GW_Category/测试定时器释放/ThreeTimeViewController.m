//
//  ThreeTimeViewController.m
//  GW_Category
//
//  Created by zdwx on 2020/1/4.
//  Copyright © 2020 gw. All rights reserved.
//

#import "ThreeTimeViewController.h"
#import "UIViewController+GWViewController.h"
#import "TestTimeDeallocViewController.h"
#import "TwoTImeViewController.h"
#import "UINavigationController+GWNavigationController.h"

@interface ThreeTimeViewController ()
@property (strong ,nonatomic) NSTimer *oneTime;

@end

@implementation ThreeTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    [self setUI];
}

- (void)btnAction{
    TwoTImeViewController *popVC = [TwoTImeViewController new];
//    TestTimeDeallocViewController *popVC = [TestTimeDeallocViewController new];
    popVC.index = self.index+1;
//    UINavigationController *popNav = [[UINavigationController alloc] initWithRootViewController:popVC];
//    [self presentViewController:popNav animated:YES completion:nil];
    [self.navigationController pushViewController:popVC animated:YES];
}

- (void)btn2Action{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [self gw_dismissToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    for (UIViewController *subVC in self.navigationController.childViewControllers) {
//        if ([subVC isKindOfClass:[TestTimeDeallocViewController class]]) {
//            [self.navigationController popToViewController:subVC animated:YES];
//            break;
//        }
//    }
    [self gw_dismissToViewController:@"TestTimeDeallocViewController" animated:YES];
    
//    [self.navigationController GW_RemoveNavSubVC:[TwoTImeViewController class]];
}

#pragma mark - UI
- (void)setUI{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(10, 200, 200, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:btn2];
    btn2.frame = CGRectMake(10, 400, 200, 30);
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"back" forState:UIControlStateNormal];
    _oneTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_oneTime forMode:NSRunLoopCommonModes];
}

- (void)timeAction{
    NSLog(@"TwoTImeViewController - go - %ld",(long)self.index);
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
    NSLog(@"TwoTImeViewController - dealloc");
}

@end
