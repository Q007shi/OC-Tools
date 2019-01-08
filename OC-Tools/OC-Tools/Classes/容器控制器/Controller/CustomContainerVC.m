//
//  CustomContainerVC.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/7.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "CustomContainerVC.h"

//https://www.cnblogs.com/silence-cnblogs/p/6370049.html

@interface CustomContainerVC (){
    UIViewController *v1;
    UIViewController *v2;
}

@end

@implementation CustomContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义容器控制器";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(change)];
    v1 = [UIViewController new];
    v1.view.backgroundColor = [UIColor orangeColor];
    [self displayContentController:v1];
    v2 = [UIViewController new];
    v2.view.backgroundColor = [UIColor blueColor];
}

- (void)change{
    [self hideContentController:v2];
    [self cycleFromViewController:v1 toViewController:v2];
}


//1.添加子视图控制器
//这里主要就是使用addChildViewController方法添加

- (void)displayContentController: (UIViewController*) content {
    //the addChildViewController: method calls the child’s willMoveToParentViewController:
    [self addChildViewController:content];
    content.view.frame = self.view.bounds;
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}

//2.移除子视图控制器
//这里主要使用removeFromParentViewController方法移除

- (void) hideContentController: (UIViewController*) content {
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    //The removeFromParentViewController method also calls the child’s didMoveToParentViewController: method, passing that method a value of nil.
    [content removeFromParentViewController];
    
}
//3.视图的切换显示
//这个往往是最重要的,也是我们可以真正自定义的地方,主要涉及到自定的视图切换动效等。

- (void)cycleFromViewController: (UIViewController*) oldVC toViewController: (UIViewController*) newVC { // Prepare the two view controllers for the change.
    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC]; // Get the start frame of the new view controller and the end frame // for the old view controller. Both rectangles are offscreen. //设置newVC的frame
    CGRect rect = self.view.bounds;
    rect.origin.x += CGRectGetWidth(self.view.bounds);
    newVC.view.frame = rect; //获取oldVC的frame
    CGRect endFrame = oldVC.view.bounds;
    endFrame.origin.x -= CGRectGetWidth(self.view.bounds); //动画转场
    [self transitionFromViewController:oldVC toViewController:newVC duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{ // Animate the views to their final positions.
        newVC.view.frame = oldVC.view.frame;
        oldVC.view.frame = endFrame;
    } completion:^(BOOL finished) { // Remove the old view controller and send the final // notification to the new view controller.
        [oldVC removeFromParentViewController];
        [newVC didMoveToParentViewController:self];
    }];
}





@end
