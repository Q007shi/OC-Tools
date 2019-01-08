//
//  CustomContainerVC.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/7.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomContainerVC : UIViewController

//展现controller
- (void) displayContentController: (UIViewController*) content;
//隐藏controller
- (void) hideContentController: (UIViewController*) content;
//页面切换
- (void)cycleFromViewController: (UIViewController*) oldVC toViewController: (UIViewController*) newVC;

@end

