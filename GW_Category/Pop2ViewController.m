//
//  Pop2ViewController.m
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//

#import "Pop2ViewController.h"
#import "TestView.h"
@interface Pop2ViewController ()

@end

@implementation Pop2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview: [TestView alertV]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self isWillDisappearAndDeallocVC]) {
        NSLog(@"Pop2ViewController - disappear");
    }
}

- (void)dealloc{
    NSLog(@"Pop2ViewController - dealloc");
}

@end
