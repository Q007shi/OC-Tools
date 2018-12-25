//
//  FCCategoryBaseModel.h
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCCategoryBaseCellModel : NSObject

/** cell的顺序 */
@property(nonatomic,assign)NSUInteger index;
/** 是否选中 */
@property(nonatomic,assign)BOOL selected;
/** cell 的宽度 */
@property(nonatomic,assign)CGFloat cellWidth;
/** cell 之间的间距 */
@property(nonatomic,assign)CGFloat cellSpacing;
/** cell 是否有放大效果 */
@property(nonatomic,assign)BOOL cellWidthZoomEnabled;
/** cell 放大比例 */
@property(nonatomic,assign)CGFloat cellWidthZoomScale;


@end

