//
//  NSString+CFCategory.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (CFCategory)

/** 字符串是否为空 */
@property(nonatomic,assign,readonly)BOOL fc_isEmpty;

/**
 根据正则表达式字符串 regex 将字符串截取，并将截取结果返回
 @param regex 正则表达式字符串
 @return 截取结果，如果异常返回 nil
 */
-(NSArray<NSTextCheckingResult *> *)trimSourceStringWithRegex:(NSString *)regex;

@end

