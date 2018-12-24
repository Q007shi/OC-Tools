//
//  MainTabBarController.m
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVC:[TestVC new] title:@"测试" imageName:@""];
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName{
    childVC.tabBarItem.title = title;
    BaseNavigationController *navigationController = [[BaseNavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:navigationController];
}



@end
