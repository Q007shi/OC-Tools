//
//  UIButton+FCButton.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/2/2.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "UIButton+FCButton.h"

@implementation UIButton (FCButton)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    [self setBackgroundImage:backgroundColor.fc_transformImage forState:state];
}

@end
