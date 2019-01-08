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
    unsigned int didScrollSelectedItemAtIndexFlag : 1;
    unsigned int didClickedItemContentScrollViewTransitionToIndexFlag : 1;
    unsigned int scrollingFromLeftIndexToRightIndexFlag : 1;
    
};

@interface FCCategoryBaseView ()<UICollectionViewDataSource,UICollectionViewDelegate>

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
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[FCCategoryCollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    [self addSubview:self.collectionView];
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
    self.collectionView.frame = self.bounds;
    [self reloadData];
}

#pragma mark - setter 方法
- (void)setDelegate:(id<FCCategoryViewDelegate>)delegate{
    _delegate = delegate;
    
    //点击选中和滚动选中都会调用该方法
    _delegateFlag.didSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didSelectedItemAtIndex:)];
    //点击选中时触发
    _delegateFlag.didClickSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didClickSelectedItemAtIndex:)];
    //滚动 contentScrollView 时选中出发
    _delegateFlag.didScrollSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didScrollSelectedItemAtIndex:)];
    //点击选中时 contentScrollView 滚到到对应位置
    _delegateFlag.didClickedItemContentScrollViewTransitionToIndexFlag = [delegate respondsToSelector:@selector(categoryView:contentScrollViewTransitionToIndex:)];
    //正在滚动中的回调
    _delegateFlag.scrollingFromLeftIndexToRightIndexFlag = [delegate respondsToSelector:@selector(categoryView:scrollingFromLeftIndex:toRightIndex:ratio:)];
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

#pragma mark - subclass override
- (void)refreshDataSource{
    
}
- (void)refreshState{
    if (self.selectedIndex < 0 || self.selectedIndex >= self.dataSource.count) {
        _selectedIndex = 0;
    }

/**-------------------- 计算 cellWidth 和 cell 之间的间距 ------------------------*/
    
    //cell 之间的间距
    self.innerCellSpacing = self.cellSpacing;
    //总的内容高度(左边距+cell总宽度+总cellSpacing+右边距)
    __block CGFloat totalItemWidth = [self getContentEdgeInsetLef];
    //总的 cell 宽度
    __block CGFloat totalCellWidth = 0.0;
    for (NSUInteger i = 0; self.dataSource.count; i++) {
        FCCategoryBaseCellModel *cellModel = self.dataSource[i];
        cellModel.index = i;
        cellModel.cellWidth = [self preferredCellWithAtIndex:i] + self.cellWidthIncrement;
        cellModel.cellWidthZoomEnabled = self.cellWidthZoomEnabled;
        cellModel.cellSpacing = self.innerCellSpacing;
        if (i == self.selectedIndex) {
            cellModel.selected = YES;
            cellModel.cellWidthZoomScale = self.cellWidthZoomScale;
        }else{
            cellModel.selected = NO;
            cellModel.cellWidthZoomScale = 1.0;
        }
        totalCellWidth += cellModel.cellWidth;
        if (i == self.dataSource.count - 1) {
            totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
        }else{
            totalItemWidth += cellModel.cellWidth + self.innerCellSpacing;
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
    
/**-------------- 初始化居中 -----------------*/
    //选中 cell 的起始位置
    __block CGFloat frameXOfSelectedCell = self.innerCellSpacing;
    //选中 cell 的宽度
    __block CGFloat selectedCellWidth = 0;
    //
    totalItemWidth = [self getContentEdgeInsetLef];
    [self.dataSource enumerateObjectsUsingBlock:^(FCCategoryBaseCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            frameXOfSelectedCell += obj.cellWidth + self.innerCellSpacing;
        }else if(idx == self.selectedIndex){
            selectedCellWidth = obj.cellWidth;
        }
        if (idx == self.dataSource.count - 1) {
            totalItemWidth += obj.cellWidth + [self getContentEdgeInsetRight];
        }else{
            totalItemWidth += obj.cellWidth + self.innerCellSpacing;
        }
    }];
    
    CGFloat minX = 0;
    CGFloat maxX = totalItemWidth - self.bounds.size.width;
    CGFloat targetX = frameXOfSelectedCell - self.bounds.size.width/2.0 + selectedCellWidth/2.0;
    [self.collectionView setContentOffset:CGPointMake(MAX(MIN(maxX, targetX), minX), 0) animated:NO];
}


- (BOOL)selectCellAtIndex:(NSInteger)targetIndex isClicked:(BOOL)isClicked{
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
            if (self.delegateFlag.didScrollSelectedItemAtIndexFlag) {
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
    
    //忽略缩放效果
    
    //
    if (isClicked) {
        if (self.delegateFlag.didClickedItemContentScrollViewTransitionToIndexFlag) {
            [self.delegate categoryView:self didClickedItemContentScrollViewTransitionToIndex:targetIndex];
        }else{
            [self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];
        }
    }
    _selectedIndex = targetIndex;
    if (isClicked) {
        if (self.delegateFlag.didClickSelectedItemAtIndexFlag) {
            [self.delegate categoryView:self didClickSelectedItemAtIndex:targetIndex];
        }
    }else {
        if (self.delegateFlag.didScrollSelectedItemAtIndexFlag) {
            [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
        }
    }
    if (self.delegateFlag.didSelectedItemAtIndexFlag) {
        [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
    }
    
    return YES;
}

- (void)refreshSelectedCellModel:(FCCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(FCCategoryBaseCellModel *)unselectedCellModel{
    selectedCellModel.selected = YES;
    selectedCellModel.cellWidthZoomScale = self.cellWidthZoomScale;
    unselectedCellModel.selected = NO;
    unselectedCellModel.cellWidthZoomScale = 1.0;
}
//关联的contentScrollView的contentOffset发生了改变
- (void)contentOffsetOfContentScrollViewDidChanged:(CGFloat)contentOffset{
    
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
