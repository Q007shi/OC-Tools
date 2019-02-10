//
//  InputActionView.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/2/2.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,InputActionViewType){
    InputActionViewTypeAudio = 1,//录音
    InputActionViewTypeEmoji = 1 << 1,//表情
    InputActionViewTypeCustomAction = 1 << 2,//自定义事件
};
@interface InputActionView : UIView

/** 内容默认：InputActionViewTypeAudio | InputActionViewTypeEmoji | InputActionViewTypeCustomAction */
@property(nonatomic,assign)InputActionViewType actionViewType;

@end


