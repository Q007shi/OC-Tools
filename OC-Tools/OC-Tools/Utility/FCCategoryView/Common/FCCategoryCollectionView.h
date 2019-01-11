//
//  FCCategoryCollectionView.h
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FCCategoryCollectionView : UICollectionView

/** 指示器 */
@property(nonatomic,strong)NSArray<UIView<FCCategoryIndicatorProtocol> *> *indicators;

@end

