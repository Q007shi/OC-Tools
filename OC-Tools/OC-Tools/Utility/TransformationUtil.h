//
//  TransformationUtil.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/8.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 过度工具 */
@interface TransformationUtil : NSObject

/**
 过度工具，将 fromValue 转换为 toValue

 @param fromValue 起始值
 @param toValue 结束值
 @param percent 百分比(0~1)
 @return 转换结果
 */
+ (CGFloat)transformationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue percent:(CGFloat)percent;

@end

