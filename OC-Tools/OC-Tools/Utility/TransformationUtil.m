//
//  TransformationUtil.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/8.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "TransformationUtil.h"

@implementation TransformationUtil

//值转换工具，将 fromValue 转换为 toValue
+ (CGFloat)transformationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue percent:(CGFloat)percent{
    percent = MAX(0, MIN(1, percent));
    return fromValue + (toValue - fromValue)*percent;
}

@end
