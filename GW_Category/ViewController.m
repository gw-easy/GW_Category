//
//  ViewController.m
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//

#import "ViewController.h"
#import "PopTestVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PopTestVC *popVC = [PopTestVC new];
//        UINavigationController *popNav = [[UINavigationController alloc] initWithRootViewController:popVC];
//        [self presentViewController:popVC animated:YES completion:nil];
        [self.navigationController pushViewController:popVC animated:YES];
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

@end
