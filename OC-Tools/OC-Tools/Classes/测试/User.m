//
//  User.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/5.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "User.h"

@implementation User

- (void)abc{
    if (self.delegate && [self.delegate respondsToSelector:@selector(test)]) {
        NSLog(@"%zd",[self.delegate test]);
    }
}

@end
