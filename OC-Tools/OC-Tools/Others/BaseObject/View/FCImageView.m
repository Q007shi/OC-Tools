//
//  FCImageView.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/11/28.
//  Copyright © 2018年 KPNetworking. All rights reserved.
//

#import "FCImageView.h"

@interface FCImageView ()

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation FCImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _cornerRadius = 0.0f;
    _imageCornerType = FCImageCornerTypeNone;
    _borderWidth = 0.0f;
    _borderColor = [UIColor clearColor];
    //UI布局
    [self setupUI];
}
//MARK: UI布局
- (void)setupUI{
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_imageView];
    self.backgroundColor = [UIColor clearColor];
}

//MARK: setter 方法
- (void)setImage:(UIImage *)image{
    _image = image;
    [self setupData];
}
- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    [self setupData];
}
- (void)setImageCornerType:(FCImageCornerType)imageCornerType{
    _imageCornerType = imageCornerType;
    [self setupData];
}
- (void)setContentMode:(UIViewContentMode)contentMode{
    _contentMode = contentMode;
    [self setupData];
}
- (void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    [self setupData];
}
- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    [self setupData];
}
//MARK: 赋值
- (void)setupData{
    if (nil != _image && [_image isKindOfClass:[UIImage class]] && _cornerRadius >= 0 && _imageCornerType >= FCImageCornerTypeNone && _contentMode >= UIViewContentModeScaleToFill) {
        self.imageView.contentMode = self.contentMode;
        switch (_imageCornerType) {
            case FCImageCornerTypeNone:{
                _cornerRadius = 0;
            }break;
            case FCImageCornerTypeRounded:{
                _cornerRadius = MIN(self.bounds.size.width, self.bounds.size.height)*0.5;
            }break;
            case FCImageCornerTypeRadiusCorner:{
                if (_cornerRadius > MIN(self.bounds.size.width, self.bounds.size.height)*0.5) {
                    _cornerRadius = MIN(self.bounds.size.width, self.bounds.size.height)*0.5;
                }
            }break;
        }
        self.imageView.image = [self imageAddCornerWithRadius:self.cornerRadius addSize:self.bounds.size];
    }
}

//MARK: 重绘图片
- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius addSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //开启图片图形上下文，图片大小、是否透明、比例
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //为上下文添加裁取区域
    CGContextAddPath(ctx, self.path);
    //截取上下文
    CGContextClip(ctx);
    //
    [self.image drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//MARK: 指定图片裁取区域
- (CGPathRef)path{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.borderWidth, self.borderWidth, self.bounds.size.width-self.borderWidth*2, self.bounds.size.height-self.borderWidth*2) cornerRadius:self.cornerRadius];
    path.lineCapStyle = kCGLineCapSquare;
    if (self.borderWidth > 0) {
        path.lineWidth = self.borderWidth;
        if (nil != self.borderColor && [self.borderColor isKindOfClass:[UIColor class]]) {
            [self.borderColor set];
            [path stroke];
        }
    }
    return path.CGPath;
}

@end

@implementation FCImageView (SDWebImageCache)

- (void)fc_setImageWithURL:(nonnull NSURL *)url{
    [self.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.image = image;
    }];
}
- (void)fc_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nonnull UIImage *)placeholder{
    [self.imageView sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.image = image;
    }];
}

@end
