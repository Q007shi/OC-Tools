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
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
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
    //cell 之间的间距
    self.innerCellSpacing = self.cellSpacing;
    
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
