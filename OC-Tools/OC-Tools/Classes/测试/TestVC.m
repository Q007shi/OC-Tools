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
    
    NSMutableArray *array = [NSMutableArray new];
    for (int t = 0; t< 4; t++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor fc_randomColor];
        [array addObject:view];
        [self.view addSubview:view];
    }
    
//    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
//    //整体的位置
//    [array mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.mas_equalTo(self.view);
//    }];
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.height.equalTo(@70);
        // make.bottom.equalTo(self);
    }];
    
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(10, 200, 100, 50)];
    textF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textF];
    textF.allowsEditingTextAttributes = NO;
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = [UIImage imageNamed:@"good1_30x30_"];
    attachment.bounds = CGRectMake(0, 0, 30, 30);
    textF.attributedText = [NSAttributedString attributedStringWithAttachment:attachment];
    
    UIImageView *iView = [[UIImageView alloc]initWithImage:attachment.image];
    [self.view addSubview:iView];
    iView.center = self.view.center;
    
    textF.selectedTextRange;
    
    
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
