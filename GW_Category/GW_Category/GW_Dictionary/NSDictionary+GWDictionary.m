//
//  NSDictionary+GWDictionary.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/18.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSDictionary+GWDictionary.h"
#import "NSObject+GWObject.h"
@implementation NSDictionary (GWDictionary)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzling_GW:@selector(initWithObjects:forKeys:count:)  systemClass:NSClassFromString(@"__NSPlaceholderDictionary")  exchangeMethodSel:@selector(initWithObjects_GW:forKeys:count:)  exchangeClass:[self class]];
    });
}

#pragma mark --- 防止字典crash
- (instancetype)initWithObjects_GW:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }else{
            rightCount++;
        }
    }
    self = [self initWithObjects_GW:objects forKeys:keys count:rightCount];
    return self;
}
@end
