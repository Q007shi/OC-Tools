//
//  CTMediator+Actions.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/7.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "CTMediator+Actions.h"

@implementation CTMediator (Actions)

- (void)actionUrl:(NSString *)actionUrlStr{
    if (actionUrlStr) {
        actionUrlStr = [actionUrlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        actionUrlStr = [actionUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *actionUrl = [NSURL URLWithString:actionUrlStr];
        id obj = [self performActionWithUrl:actionUrl completion:nil];
        if ([obj isKindOfClass:[UIViewController class]]) {
            [self pushViewController:obj];
        }else{
            NSLog(@"%@",NSStringFromSelector(_cmd));
            [self pushViewController:[UIViewController new]];
        }
    }
    
    
}

- (void)LiveBroadcast:(NSDictionary *)params{
    id obj = [self performTarget:@"Actions" action:@"LiveBroadcast" params:params shouldCacheTarget:NO];
    if ([obj isKindOfClass:[UIViewController class]]) {
        [self pushViewController:obj];
    }else{
        NSLog(@"%@",NSStringFromSelector(_cmd));
        [self pushViewController:[UIViewController new]];
    }
}


#pragma push 跳转
- (void)pushViewController:(UIViewController *)vc{
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navController = (UINavigationController *)tabBarController.selectedViewController;
    [navController pushViewController:vc animated:YES];
}

@end
