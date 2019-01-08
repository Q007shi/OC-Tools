//
//  FCCategoryBaseView.m
//  OC-Tools
//
//  Created by 石富才 on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "FCCategoryBaseView.h"

struct DelegateFlags{
    unsigned int didSelectedItemAtIndexFlag : 1;
    unsigned int didClickSelectedItemAtIndexFlag : 1;
    unsigned int didScrollSelectedItemAtIndexFlagt : 1;
    unsigned int contentScrollViewTransitionToIndexFlag : 1;
    unsigned int scrollingFromLeftIndexToRightIndexFlag : 1;
    
};

@interface FCCategoryBaseView ()

/** 代理标记 */
@property(nonatomic,assign)struct DelegateFlags delegateFlag;

/**  */
@property(nonatomic,assign)CGFloat innerCellSpacing;
@property (nonatomic, assign) CGPoint lastContentViewContentOffset;



@end

@implementation FCCategoryBaseView

- (void)dealloc{
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (void)setDelegate:(id<FCCategoryViewDelegate>)delegate{
    _delegate = delegate;
    
    //点击选中和滚动选中都会调用该方法
    _delegateFlag.didSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didSelectedItemAtIndex:)];
    //点击选中时触发
    _delegateFlag.didClickSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didClickSelectedItemAtIndex:)];
    //滚动 contentScrollView 时选中出发
    _delegateFlag.didScrollSelectedItemAtIndexFlagt = [delegate respondsToSelector:@selector(categoryView:didScrollSelectedItemAtIndex:)];
    //点击选中时 contentScrollView 滚到到对应位置
    _delegateFlag.contentScrollViewTransitionToIndexFlag = [delegate respondsToSelector:@selector(categoryView:contentScrollViewTransitionToIndex:)];
    //正在滚动中的回调
    _delegateFlag.scrollingFromLeftIndexToRightIndexFlag = [delegate respondsToSelector:@selector(categoryView:scrollingFromLeftIndex:toRightIndex:ratio:)];
}

#pragma mark - 初始化 Data
- (void)initializeData{
    _dataSource = [NSMutableArray array];
    _selectedIndex = 0;
    _cellWidth = FCCategoryViewAutomaticDimension;
    _cellWidthIncrement = 0;
    _cellSpacing = 20;
    _averageCellSpacingEnabled = YES;
    _cellWidthZoomEnabled = NO;
    _cellWidthZoomScale = 1.2;
    _cellWidthZoomScrollGradientEnabled = YES;
    _contentEdgeInsetLeft = FCCategoryViewAutomaticDimension;
    _contentEdgeInsetRight = FCCategoryViewAutomaticDimension;
    _lastContentViewContentOffset = CGPointZero;
    
}
#pragma mark - 初始化 UI
- (void)initializeViews{
    self.collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        FCCategoryCollectionView *collectionView = [[FCCategoryCollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView;
    });
    [self addSubview:self.collectionView];
}

- (void)setDefaultSelectedIndex:(NSUInteger)defaultSelectedIndex{
    _defaultSelectedIndex = defaultSelectedIndex;
    _selectedIndex = defaultSelectedIndex;
}
- (void)setContentScrollView:(UIScrollView *)contentScrollView{
    if (_contentScrollView != nil) {
        [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _contentScrollView = contentScrollView;
    [contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)reloadData{
    [self refreshDataSource];
    [self refreshState];
    //取消布局
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

- (void)reloadCellAtIndex:(NSUInteger)index{
    if (index >= self.dataSource.count) return;
    FCCategoryBaseCellModel *cellModel = self.dataSource[index];
    [self refreshCellModel:cellModel index:index];
    FCCategoryBaseCell *cell = (FCCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell reloadData:cellModel];
}

- (void)selectItemAtIndex:(NSUInteger)index{
    [self selectedCellAtIndex:index isClicked:YES];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self reloadData];
}

#pragma mark - subclass override
- (void)refreshDataSource{
    
}
- (void)refreshState{
    if (self.selectedIndex >= self.dataSource.count) {
        _selectedIndex = 0;
    }

/**-------------------- 计算 cellWidth 和 cell 之间的间距 ------------------------*/
    
    //cell 之间的间距
    self.innerCellSpacing = self.cellSpacing;
    //内容的宽度
    __block CGFloat totalItemWidth = [self getContentEdgeInsetLef];
    //所有 Cell 的宽度
    __block CGFloat totalCellWidth = 0.0;
    for (NSUInteger i = 0; self.dataSource.count; i++) {
        FCCategoryBaseCellModel *cellModel = self.dataSource[i];
        cellModel.index = i;
        cellModel.cellWidth = [self preferredCellWithAtIndex:i] + self.cellWidthIncrement;
        totalCellWidth += cellModel.cellWidth;
        cellModel.cellWidthZoomEnabled = self.cellWidthZoomEnabled;
        cellModel.cellWidthZoomScale = 1.0;
        cellModel.cellSpacing = self.cellSpacing;
        if (i == self.dataSource.count - 1) {
            totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
        }else{
            totalItemWidth += cellModel.cellWidth + self.cellSpacing;
        }
        if (i == self.selectedIndex) {
            cellModel.selected = YES;
            cellModel.cellWidthZoomScale = self.cellWidthZoomScale;
        }else{
            cellModel.selected = NO;
        }
        [self refreshCellModel:cellModel index:i];
    }
    
    //总内容宽度小于视图宽度，将 cellWidth 均分
    if (self.averageCellSpacingEnabled && totalItemWidth < self.bounds.size.width) {
        NSUInteger cellSpacingItemCount = self.dataSource.count - 1;
        CGFloat totalCellSpacingWidth = self.bounds.size.width - totalCellWidth;
        //如果内容左边距离是 Automatic，就加 1
        if (self.contentEdgeInsetLeft == FCCategoryViewAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else{
            totalCellSpacingWidth -= self.contentEdgeInsetLeft;
        }
        if (self.contentEdgeInsetRight == FCCategoryViewAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else{
            totalCellSpacingWidth -= self.contentEdgeInsetRight;
        }
        
        CGFloat cellSpacing = 0;
        if (cellSpacingItemCount > 0) {
            cellSpacing = totalCellSpacingWidth/cellSpacingItemCount;
        }
        self.innerCellSpacing = cellSpacing;
        [self.dataSource enumerateObjectsUsingBlock:^(FCCategoryBaseCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.cellSpacing = cellSpacing;
        }];
    }
    
/**-------------- 选中居中 -----------------*/
    //选中 cell 的起始位置
    __block CGFloat frameXOfSelectedCell = self.innerCellSpacing;
    //选中 cell 的宽度
    __block CGFloat selectedCellWidth = 0;
    //
    totalItemWidth = self.innerCellSpacing;
    [self.dataSource enumerateObjectsUsingBlock:^(FCCategoryBaseCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            frameXOfSelectedCell += obj.cellWidth + obj.cellSpacing;
        }else{
            selectedCellWidth = obj.cellWidth;
        }
        totalItemWidth += obj.cellWidth + self.innerCellSpacing;
    }];
    
    CGFloat minX = 0;
    CGFloat maxX = totalItemWidth - self.bounds.size.width;
    CGFloat targetX = frameXOfSelectedCell - self.bounds.size.width/2.0 + selectedCellWidth/2.0;
    [self.collectionView setContentOffset:CGPointMake(MAX(MIN(maxX, targetX), minX), 0) animated:NO];
}


- (BOOL)_selectCellAtIndex:(NSInteger)targetIndex handleContentScrollView:(BOOL)handleContentScrollView isClicked:(BOOL)isClicked{
    if (targetIndex >= self.dataSource.count) {
        return NO;
    }
    
    /**------------- 触发代理方法 -------------*/
    if (self.selectedIndex == targetIndex) {
        if (isClicked) {
            if (self.delegateFlag.didClickSelectedItemAtIndexFlag) {
                [self.delegate categoryView:self didClickSelectedItemAtIndex:targetIndex];
            }
        }else{
            if (self.delegateFlag.didScrollSelectedItemAtIndexFlagt) {
                [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
            }
        }
        if (self.delegateFlag.didSelectedItemAtIndexFlag) {
            [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
        }
        return NO;
    }
    
    /**------------ 刷新 cell 中数据 --------------*/
    FCCategoryBaseCellModel *lastCellModel = self.dataSource[self.selectedIndex];
    FCCategoryBaseCellModel *selectedCellModel = self.dataSource[targetIndex];
    [self refreshSelectedCellModel:selectedCellModel unselectedCellModel:lastCellModel];
    
    FCCategoryBaseCell *lastCell = (FCCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    [lastCell reloadData:lastCellModel];
    
    FCCategoryBaseCell *selectedCell = (FCCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0]];
    [selectedCell reloadData:selectedCellModel];
    
    return YES;
}

#pragma mark - Private，私有方法
- (CGFloat)getContentEdgeInsetLef{
    if (self.contentEdgeInsetLeft == FCCategoryViewAutomaticDimension) {
        return self.innerCellSpacing;
    }
    return self.contentEdgeInsetLeft;
}
- (CGFloat)getContentEdgeInsetRight{
    if (self.contentEdgeInsetRight == FCCategoryViewAutomaticDimension) {
        return self.innerCellSpacing;
    }
    return self.contentEdgeInsetRight;
}
- (void)clickselectedItemAtIndex:(NSInteger)index{
    [self selectedCellAtIndex:index isClicked:YES];
}
- (void)scrollselectItemAtIndex:(NSInteger)index{
    [self selectedCellAtIndex:index isClicked:NO];
}




@end
