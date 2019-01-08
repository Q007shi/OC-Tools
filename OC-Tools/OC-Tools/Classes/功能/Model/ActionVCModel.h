//
//  ActionModel.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/26.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ActionModel;
@interface ActionVCModel : NSObject

/** <#aaa#> */
@property(nonatomic,copy)NSString *sectionTitle;

/** <#aaa#> */
@property(nonatomic,copy)NSString *sectionIndexTitle;

/** <#aaa#> */
@property(nonatomic,copy)NSString *tag;

/** <#aaa#> */
@property(nonatomic,strong)NSArray<ActionModel *> *actions;

@end

@interface ActionModel : NSObject

/** <#aaa#> */
@property(nonatomic,copy)NSString *title;
/** <#aaa#> */
@property(nonatomic,copy)NSString *url;

@end
