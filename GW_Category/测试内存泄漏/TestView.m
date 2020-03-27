//
//  TestView.m
//  GW_Category
//
//  Created by zdwx on 2020/1/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import "TestView.h"
static TestView *aaa = nil;
@implementation TestView

+ (instancetype)alertV{
    TestView *view = [TestView new];
    aaa = view;
    return aaa;
}

- (void)dealloc{
    NSLog(@"TestView - dealloc");
}
@end
