//
//  UIColor+FCCategory.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/18.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

struct RGBA{
    CGFloat R;//[0,1]
    CGFloat G;//[0,1]
    CGFloat B;//[0,1]
    CGFloat A;//[0,1]
};

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FCCategory)

/** 获取当前颜色的 RGBA 值 */
- (struct RGBA)rgba;

/** 十六进制色值(0xffffff)转 UIColor */
+ (instancetype)hexValue:(UInt32)hexValue;
/** 十六进制色值字符串(0xffffff 活 #ffffff) 转 UIColor */
+ (instancetype)hexValueString:(NSString *)hexValueString;

@end

NS_ASSUME_NONNULL_END
