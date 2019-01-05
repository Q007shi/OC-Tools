//
//  UITableViewRowAction+FCCategory.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/29.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewRowAction (FCCategory)

/** 图片 */
@property(nonatomic,strong)UIImage *fc_image;
/** 字体 */
@property(nonatomic,strong)UIFont *fc_font;
/** 字体颜色 */
@property(nonatomic,strong)UIColor *fc_textColor;
/** 背景图片 */
@property(nonatomic,strong)UIImage *fc_backgroundImage;

@end

