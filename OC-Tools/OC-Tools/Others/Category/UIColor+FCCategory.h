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


@interface UIColor (FCCategory)

/** 获取当前颜色的 RGBA 值 */
- (struct RGBA)fc_rgba;

/** 随机色 */
+ (instancetype)fc_randomColor;

/** 获取当前颜色的透明度 */
- (CGFloat)fc_alpha;

/** 十六进制色值(0xffffff)转 UIColor */
+ (instancetype)fc_hexValue:(UInt32)hexValue;
/** 十六进制色值字符串(0xffffff 活 #ffffff) 转 UIColor */
+ (instancetype)fc_hexValueString:(NSString *)hexValueString;

/**
 fromColor 到 toColor 的渐变色

 @param fromColor 起始颜色
 @param toColor 结束颜色
 @param percent 百分比
 @return 当前颜色
 */
+ (instancetype)fc_fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent;
/**
 fromColor 到 toColor 的渐变色
 
 @param fromColor 起始颜色
 @param toColor 结束颜色
 @param percent 百分比
 @param alpha 透明度
 @return 当前颜色
 */
+ (instancetype)fc_fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent alpha:(CGFloat)alpha;

/**
 将当前颜色转换成 10X10 的图片

 @return 10X10 的图片
 */
- (UIImage *)fc_transformImage;

@end

