//
//  FCCategoryBaseCell.h
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FCCategoryBaseCell : UICollectionViewCell

/** cell 显示内容 */
@property(nonatomic,strong)FCCategoryBaseModel *cellModel;

/** 初始化子视图(子类重写必须先调 supper) */
- (void)initializeView NS_REQUIRES_SUPER;

/** 刷新当前 cell 的数据(子类重写必须先调 supper) */
- (void)reloadData:(FCCategoryBaseModel *)cellModel NS_REQUIRES_SUPER;

@end
