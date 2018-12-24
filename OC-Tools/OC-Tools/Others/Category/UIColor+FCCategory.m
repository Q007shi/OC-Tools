//
//  UIColor+FCCategory.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/18.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "UIColor+FCCategory.h"

@implementation UIColor (FCCategory)

//获取当前颜色的 RGBA 值
- (struct RGBA)fc_rgba{
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    struct RGBA rgba = {r,g,b,a};
    return rgba;
}
//获取当前颜色的透明度 
- (CGFloat)fc_alpha{
    return CGColorGetAlpha(self.CGColor);
}

//十六进制色值(0xffffff)转 UIColor
+ (instancetype)fc_hexValue:(UInt32)hexValue{
    return [UIColor colorWithRed:((CGFloat)((hexValue & 0xff0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xff00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xff))/255.0 alpha:1];
}

//十六进制色值字符串(0xffffff 活 #ffffff) 转 UIColor
+ (instancetype)fc_hexValueString:(NSString *)hexValueString{
    if ([hexValueString hasPrefix:@"0x"] || [hexValueString hasPrefix:@"#"]) {
        hexValueString = [hexValueString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        hexValueString = [hexValueString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    }else{
        return [UIColor clearColor];
    }
    CGFloat alpha, red, blue, green;
    switch ([hexValueString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: hexValueString start: 0 length: 1];
            green = [self colorComponentFrom: hexValueString start: 1 length: 1];
            blue  = [self colorComponentFrom: hexValueString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: hexValueString start: 0 length: 1];
            red   = [self colorComponentFrom: hexValueString start: 1 length: 1];
            green = [self colorComponentFrom: hexValueString start: 2 length: 1];
            blue  = [self colorComponentFrom: hexValueString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: hexValueString start: 0 length: 2];
            green = [self colorComponentFrom: hexValueString start: 2 length: 2];
            blue  = [self colorComponentFrom: hexValueString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: hexValueString start: 0 length: 2];
            red   = [self colorComponentFrom: hexValueString start: 2 length: 2];
            green = [self colorComponentFrom: hexValueString start: 4 length: 2];
            blue  = [self colorComponentFrom: hexValueString start: 6 length: 2];
            break;
        default:
            blue=0;
            green=0;
            red=0;
            alpha=0;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+(CGFloat)colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

//fromColor 到 toColor 的渐变色
+ (instancetype)fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent{
    percent = MAX(0, MIN(1, percent));
    struct RGBA fromRGBA = fromColor.fc_rgba;
    struct RGBA toRGBA = toColor.fc_rgba;
    return [UIColor colorWithRed:(fromRGBA.R + (toRGBA.R - fromRGBA.R)*percent) green:(fromRGBA.G + (toRGBA.G - fromRGBA.G)*percent) blue:(fromRGBA.B + (toRGBA.B - fromRGBA.B)*percent) alpha:1];
}

@end
