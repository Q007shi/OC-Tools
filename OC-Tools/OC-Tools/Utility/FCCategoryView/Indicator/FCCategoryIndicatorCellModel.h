//
//  FCCategoryIndicatorCellModel.h
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "FCCategoryBaseCellModel.h"

@interface FCCategoryIndicatorCellModel : FCCategoryBaseCellModel

/** cell 之间是否显示分割线，默认 YES */
@property(nonatomic,assign)BOOL separatorLineShowEnabled;
/** cell 之间分割线颜色 */
@property(nonatomic,strong)UIColor *separatorLineColor;
/** 分割线的宽和高 */
@property(nonatomic,assign)CGSize separatorLineSize;
/** cell 的背景view的位置 */
@property(nonatomic,assign)CGRect backgroundViewMaskFrame;

/** cell 选中和未选中时是否改变颜色 */
@property(nonatomic,assign)BOOL cellBackgroundColorGradientEnable;
/** cell 未选中时的背景颜色 */
@property(nonatomic,strong)UIColor *cellBackgroundUnselectedColor;
/** cell 选中时的背景颜色 */
@property(nonatomic,strong)UIColor *cellBackgroundSelectedColor;

@end


