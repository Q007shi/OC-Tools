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
@property(nonatomic,strong,readonly)FCCategoryCollectionView *collectionView;
/** 标题信息集合 */
@property(nonatomic,strong)NSArray<FCCategoryBaseCellModel *> *dataSource;
/** 事件协议 */
@property(nonatomic,weak)id<FCCategoryViewDelegate> delegate;
/** 与 dataSource 关联的 contentScrollView */
@property(nonatomic,strong)UIScrollView *contentScrollView;
/** 初始化时,默认选择的index */
@property(nonatomic,assign)NSUInteger defaultSelectedIndex;
/** 手动选中 index */
@property(nonatomic,assign,readonly)NSUInteger selectedIndex;
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

/** 当配置属性被修改时，调用该方法刷新配置(初始化时不用调用) */
- (void)reloadData;
/** 刷新指定的 index 的 cell
内部会触发`- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index`方法进行cellModel刷新 */
- (void)reloadCellAtIndex:(NSUInteger)index;

#pragma mark - Subclass use
- (CGRect)getTargetCellFrame:(NSInteger)targetIndex;

#pragma mark - Subclass Override
- (void)initializeData NS_REQUIRES_SUPER;
- (void)initializeViews NS_REQUIRES_SUPER;

/**
 reloadData 方法调用，重新生成数据源赋值到 self.dataSource
 */
- (void)refreshDataSource;

/**
 reloadData 方法调用，根据数据源重新刷新状态
 */
- (void)refreshState NS_REQUIRES_SUPER;

/**
 用户点击某个 item，刷新选中与取消选中的 cellModel
 @param selectedCellModel 选中的 cellModel
 @param unselectedCellModel 取消选中的 cellModel
 */
- (void)refreshSelectedCellModel:(FCCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(FCCategoryBaseCellModel *)unselectedCellModel NS_REQUIRES_SUPER;

/**
 关联的 contentScrollView 的 contentOffset 发生了改变

 @param contentOffset contentOffset 偏移量
 */
- (void)contentOffsetOfContentScrollViewDidChanged:(CGFloat)contentOffset NS_REQUIRES_SUPER;


/**
 该方法用于子类重载，如果外部要选中某个 index，请使用 '-selectedItemAtIndex:' 点击某一个 item 或者 contentScrollView 滚动到某一个 item 的时候调用。根据 selectedIndex 刷新选中状态。

 @param index 选中的 index
 @param isClicked isClicked YES：点击选中；NO：滚动选中。
 */
- (void)selectedCellAtIndex:(NSUInteger)index isClicked:(BOOL)isClicked NS_REQUIRES_SUPER;

/**
 reloadData 时，返回每个 cell 的高度

 @param index 目标 index
 @return cellWidth
 */
- (CGFloat)preferredCellWithAtIndex:(NSInteger)index;

/**
 返回自定义 cell 的 class

 @return cell class
 */
- (Class)preferredCellClass;

/**
 refreshState 时调用，重置 cellModel 的状态

 @param cellModel 待重置的 cellModel
 @param index 目标 index
 */
- (void)refreshCellModel:(FCCategoryBaseCellModel *)cellModel index:(NSInteger)index;

@end

@protocol FCCategoryViewDelegate <NSObject>

/** 点击选中和滚动选中都会调用该方法 */
- (void)categoryView:(FCCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSUInteger)index;

/** 点击选中时触发 */
- (void)categoryView:(FCCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSUInteger)index;

/** 滚动 contentScrollView 时选中出发 */
- (void)categoryView:(FCCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSUInteger)index;

/**
 只有点击的选中才会调用！！！
 因为用户点击，contentScrollView即将过渡到目标index的位置。内部默认实现`[self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];`。如果实现该代理方法，以自定义实现为准。比如将animated设置为NO，点击切换时无需滚动效果。类似于今日头条APP。
 
 @param categoryView categoryView description
 @param index index description
 */
- (void)categoryView:(FCCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index;

/**
 正在滚动中的回调
 
 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 百分比
 */
- (void)categoryView:(FCCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSUInteger)leftIndex toRightIndex:(NSUInteger)rightIndex ratio:(CGFloat)ratio;

@end

