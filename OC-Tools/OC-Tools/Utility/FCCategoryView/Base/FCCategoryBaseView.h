//
//  FCCategoryBaseView.h
//  OC-Tools
//
//  Created by 石富才 on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCCategoryViewDelegate;
@interface FCCategoryBaseView : UIView

/** 标题 collectionView */
@property(nonatomic,strong)FCCategoryCollectionView *collectionView;
/** 标题信息集合 */
@property(nonatomic,strong)NSArray<FCCategoryBaseCellModel *> *dataSource;
/** 事件协议 */
@property(nonatomic,weak)id<FCCategoryViewDelegate> delegate;
/** 与 dataSource 关联的 contentScrollView */
@property(nonatomic,strong)UIScrollView *contentScrollView;
/** 初始化时,默认选择的index */
@property(nonatomic,assign)NSUInteger defaultSelectedIndex;
/** 手动选中 index */
@property(nonatomic,assign)NSUInteger selectedIndex;
/** 整体内容距左边间距，默认：FCCategoryViewAutomaticDimension(等于 cellSpacing) */
@property(nonatomic,assign)CGFloat contentEdgeInsetLeft;
/** 整体内容距右边间距，默认：FCCategoryViewAutomaticDimension(等于 cellSpacing) */
@property(nonatomic,assign)CGFloat contentEdgeInsetRight;
/** cell 的宽度，默认：FCCategoryViewAutomaticDimension */
@property(nonatomic,assign)CGFloat cellWidth;
/** cell 宽度的补偿 */
@property(nonatomic,assign)CGFloat cellWidthIncrement;
/** cell 之间的间距，默认：20 */
@property(nonatomic,assign)CGFloat cellSpacing;
/** 当 item 内容总宽度小于 FCCategoryBaseView 宽度时，是否将 cellSpacing 均分，默认：YES */
@property(nonatomic,assign)BOOL averageCellSpacingEnabled;


/** cell 的 width 是否具有缩放效果m，默认：NO */
@property(nonatomic,assign)BOOL cellWidthZoomEnabled;
/** contentScrollView 滚动时，是否更新 width 缩放效果，默认：YES */
@property(nonatomic,assign)BOOL cellWidthZoomScrollGradientEnabled;
/** cell 缩放比例,默认：1.2 */
@property(nonatomic,assign)CGFloat cellWidthZoomScale;

/** 代码选中 index 对应的 dataSource */
- (void)selectItemAtIndex:(NSUInteger)index;

/** 当配置属性被修改时，调用该方法刷新配置 */
- (void)reloadData;
/** 刷新指定的 index 的 cell */
- (void)reloadCellAtIndex:(NSUInteger)index;

#pragma mark - Subclass use
- (CGRect)getTargetCellFrame:(NSInteger)targetIndex;

#pragma mark - Subclass Override
- (void)initializeData NS_REQUIRES_SUPER;
- (void)initializeViews NS_REQUIRES_SUPER;

@end

@protocol FCCategoryViewDelegate <NSObject>

/** 点击选中和滚动选中都会调用该方法 */
- (void)categoryView:(FCCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSUInteger)index;

/** 点击选中时触发 */
- (void)categoryView:(FCCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSUInteger)index;

/** 滚动 contentScrollView 时选中出发 */
- (void)categoryView:(FCCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSUInteger)index;

/** 点击选中时 contentScrollView 滚到到对应位置
 *  默认：[self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0)
 * 通过该代理方法，自定义 contentScrollView 的滚动位置
 */
- (void)categoryView:(FCCategoryBaseView *)categoryView contentScrollViewTransitionToIndex:(NSUInteger)index;

/**
 正在滚动中的回调
 
 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 百分比
 */
- (void)categoryView:(FCCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSUInteger)leftIndex toRightIndex:(NSUInteger)rightIndex ratio:(CGFloat)ratio;

@end

