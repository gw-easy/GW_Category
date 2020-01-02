//
//  PopTestVC.m
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//

#import "PopTestVC.h"
#import "Pop2ViewController.h"

static UIView *aaa = nil;
@interface PopTestVC ()

@end

@implementation PopTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    aaa = [UIView new];
    [self.view addSubview:aaa];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        Pop2ViewController *pop2 = [Pop2ViewController new];

//        UINavigationController *popNav2 = [[UINavigationController alloc] initWithRootViewController:pop2];
//        [self presentViewController:pop2 animated:YES completion:nil];
        [self.navigationController pushViewController:pop2 animated:YES];
    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self dismissViewControllerAnimated:YES completion:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//    });
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self isWillDisappearAndDeallocVC]) {
        
        NSLog(@"PopTestVC - disappear");
    }
}

- (void)dealloc{
    NSLog(@"dealloc");
}

@end
