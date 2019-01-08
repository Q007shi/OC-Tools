//
//  Target_Action.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/7.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "Target_Actions.h"
#import "LiveBroadcastVC.h"
#import "CustomContainerVC.h"


@implementation Target_Actions

- (id)Action_LiveBroadcast:(NSDictionary *)params{
    NSLog(@"%@",params);
    return [LiveBroadcastVC new];
}
- (id)Action_ContainerVC:(NSDictionary *)params{
    return [CustomContainerVC new];
}

@end
