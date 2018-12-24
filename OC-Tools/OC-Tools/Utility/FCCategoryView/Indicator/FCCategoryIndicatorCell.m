//
//  FCCategoryIndicatorCell.m
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "FCCategoryIndicatorCell.h"

@interface FCCategoryIndicatorCell ()

/** 分割线 */
@property(nonatomic,strong)UIView *separatorLine;

@end

@implementation FCCategoryIndicatorCell

- (void)initializeView{
    [super initializeView];
    self.separatorLine = [UIView new];
    self.separatorLine.hidden = YES;
    [self.contentView addSubview:self.separatorLine];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    FCCategoryIndicatorCellModel *indicatorCellModel = (FCCategoryIndicatorCellModel *)self.cellModel;
    CGFloat lineWidth = indicatorCellModel.separatorLineSize.width;
    CGFloat lineHeight = indicatorCellModel.separatorLineSize.height;
    self.separatorLine.frame = CGRectMake(self.bounds.size.width-lineWidth+self.cellModel.cellSpacing*0.5, (self.bounds.size.height-lineHeight)*0.5, lineWidth, lineHeight);
}

- (void)reloadData:(FCCategoryBaseModel *)cellModel{
    [super reloadData:cellModel];
    FCCategoryIndicatorCellModel *indicatorCellModel = (FCCategoryIndicatorCellModel *)cellModel;
    self.separatorLine.backgroundColor = indicatorCellModel.separatorLineColor;
    self.separatorLine.hidden = indicatorCellModel.separatorLineShowEnabled;
    
    if (indicatorCellModel.cellBackgroundColorGradientEnable) {
        if (indicatorCellModel.selected) {
            self.contentView.backgroundColor = indicatorCellModel.cellBackgroundSelectedColor;
        }else{
            self.contentView.backgroundColor = indicatorCellModel.cellBackgroundUnselectedColor;
        }
    }
    
    
};

@end
