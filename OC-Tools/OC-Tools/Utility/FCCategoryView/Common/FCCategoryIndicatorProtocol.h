//
//  FCCategoryIndicatorProtocol.h
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FCCategoryIndicatorProtocol <NSObject>



/**
 contentScrollView 在进行手势滑动时，处理指示器跟随手势变化 UI 逻辑

 @param leftCellFrame 正在过度中的两个 cell，相对位置在左边的 cell 的frame
 @param rightCellFrame 正在过度中的两个 cell，相对位置在右边的 cell 的 frame
 @param selectedPosition 当前处于选中状态的 cell 的位置
 @param percent 过度比分比
 */
-(void)fc_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(FCCategoryCellClickedPosition)selectedPosition percent:(CGFloat)percent;


/**
 点击选中了某一个 cell

 @param cellFrame cell 的 frame
 @param clickedRelativePosition 当前点击 cell 相对已选中 cell 的位置
 @param isClicked YES：点击选中；NO：滚动选中
 */
- (void)fc_selectedCell:(CGRect)cellFrame clickedRelativePosition:(FCCategoryCellClickedPosition)clickedRelativePosition isClicked:(BOOL)isClicked;

@end

