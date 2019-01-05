//
//  User.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/5.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UserDelegate;
@interface User : NSObject

/** <#aaa#> */
@property(nonatomic,weak)id<UserDelegate> delegate;

- (void)abc;

@end

@protocol UserDelegate <NSObject>

- (int)test;

@end

