//
//  FCCategoryCollectionView.m
//  OC-Tools
//
//  Created by 石富才 on 2018/12/23.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "FCCategoryCollectionView.h"

@implementation FCCategoryCollectionView

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView<FCCategoryIndicatorProtocol> *indicator in self.indicators) {
        [self sendSubviewToBack:indicator];
    }
}

@end
