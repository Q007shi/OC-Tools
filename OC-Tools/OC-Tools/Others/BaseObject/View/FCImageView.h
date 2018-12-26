//
//  FCImageView.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/11/28.
//  Copyright © 2018年 KPNetworking. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FCImageCornerType){
    /** 矩形直角头像 */
    FCImageCornerTypeNone = 1,
    /** 圆形头像 */
    FCImageCornerTypeRounded,
    /** 圆角头像 */
    FCImageCornerTypeRadiusCorner,
};

@interface FCImageView : UIControl
/** 图片 */
@property(nonatomic,strong)UIImage *image;
/** 圆角半径,默认 0。注意：该值受 imageType 限制 */
@property(nonatomic,assign)CGFloat cornerRadius;
/** 图片拐角显示方式，默认  FCImageCornerTypeNone*/
@property(nonatomic,assign)FCImageCornerType imageCornerType;
/** 图片内容显示方式，默认 UIViewContentModeScaleToFill */
@property(nonatomic)UIViewContentMode contentMode;
/** 边框宽度，默认 0 */
@property(nonatomic,assign)CGFloat borderWidth;
/** 边框颜色，默认 [UIColor clearColor] */
@property(nonatomic,strong)UIColor *borderColor;

@end

@interface FCImageView (SDWebImageCache)

- (void)fc_setImageWithURL:(nonnull NSURL *)url;
- (void)fc_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nonnull UIImage *)placeholder;

@end
