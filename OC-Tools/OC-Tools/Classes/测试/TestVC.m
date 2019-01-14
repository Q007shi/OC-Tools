//
//  TestVC.m
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "TestVC.h"
#import "User.h"

@interface TestVC ()<UserDelegate>

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"测试";
    self.view.backgroundColor = [UIColor fc_hexValueString:@"0x999999"];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    User *user = [User new];
    user.delegate = self;
    [user abc];
}

- (int)test{
    return 12;
}



@end
