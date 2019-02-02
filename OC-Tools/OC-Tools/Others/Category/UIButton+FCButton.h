//
//  UIButton+FCButton.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/2/2.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (FCButton)

/**
 *根据状态设置背景颜色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

