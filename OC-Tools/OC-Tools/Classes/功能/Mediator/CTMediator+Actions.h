//
//  CTMediator+Actions.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/7.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "CTMediator.h"


@interface CTMediator (Actions)

/** URL 跳转 */
- (void)actionUrl:(NSString *)actionUrlStr;
/** 直播间 */
- (void)LiveBroadcast:(NSDictionary *)params;

@end

