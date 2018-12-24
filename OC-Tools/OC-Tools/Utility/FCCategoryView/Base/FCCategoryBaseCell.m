//
//  FCCategoryBaseCell.m
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "FCCategoryBaseCell.h"

@implementation FCCategoryBaseCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initializeView];
    }
    return self;
}
//子视图初始化
- (void)initializeView{
    
}
//刷新当前 cell 的数据
- (void)reloadData:(FCCategoryBaseModel *)cellModel{
    self.cellModel = cellModel;
}

@end
