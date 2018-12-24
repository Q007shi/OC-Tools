//
//  FCCategoryViewDefines.h
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

static const CGFloat FCCategoryViewAutomaticDimension = -1;

//选中指示器的位置
typedef NS_ENUM(NSUInteger, FCCategoryComponentPosition) {
    FCCategoryComponentPosition_Bottom,
    FCCategoryComponentPosition_Top,
};

//点击 cell 相对当前选中 cell 的相对位置
typedef NS_ENUM(NSUInteger, FCCategoryCellClickedPosition) {
    FCCategoryCellClickedPosition_Left,
    FCCategoryCellClickedPosition_Right,
};
