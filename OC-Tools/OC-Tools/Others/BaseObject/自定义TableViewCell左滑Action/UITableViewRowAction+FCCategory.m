//
//  UITableViewRowAction+FCCategory.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/29.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "UITableViewRowAction+FCCategory.h"
#import <objc/runtime.h>

//associate  [əˈsəʊʃieɪt] 联合

@implementation UITableViewRowAction (FCCategory)

//assign:用于基本数据类型的引用，当 assign 属性失效时，它所引用的内存就会被释放。
//retain：引用计数，

//图片
- (void)setFc_image:(UIImage *)fc_image{
    //associate [əˈsəʊʃieɪt] 联合
    objc_setAssociatedObject(self, @selector(fc_image), fc_image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)fc_image{
    return objc_getAssociatedObject(self, _cmd);
}

//字体
- (void)setFc_font:(UIFont *)fc_font{
    objc_setAssociatedObject(self, @selector(fc_font), fc_font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)fc_font{
    UIFont *font = objc_getAssociatedObject(self, _cmd);
    if (!font) {
        font = [UIFont systemFontOfSize:15];
    }
    return font;
}

//字体颜色
- (void)setFc_textColor:(UIColor *)fc_textColor{
    objc_setAssociatedObject(self, @selector(fc_textColor), fc_textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)fc_textColor{
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if (!color) {
        color = [UIColor fc_hexValue:0x333333];
    }
    return color;
}

//背景图片
- (void)setFc_backgroundImage:(UIImage *)fc_backgroundImage{
    objc_setAssociatedObject(self, @selector(fc_backgroundImage), fc_backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)fc_backgroundImage{
    return objc_getAssociatedObject(self, _cmd);
}

@end
