//
//  FCCategoryBaseModel.m
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "FCCategoryBaseCellModel.h"

@implementation FCCategoryBaseCellModel

- (CGFloat)cellWidth{
    if (_cellWidthZoomEnabled) {
        return _cellWidth*_cellWidthZoomScale;
    }
    return _cellWidth;
}

@end
