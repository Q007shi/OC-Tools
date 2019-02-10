//
//  ConstHeader.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/2/2.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#ifndef ConstHeader_h
#define ConstHeader_h


#define WEAKSELF __weak typeof( self) weakSelf = self;

/** 导航栏+状态栏的高度 */
#define k_topHeight [UIApplication sharedApplication].statusBarFrame.size.height + [UINavigationBar appearance].frame.size.height
#define k_bottomHeight 32.0




#endif /* ConstHeader_h */
