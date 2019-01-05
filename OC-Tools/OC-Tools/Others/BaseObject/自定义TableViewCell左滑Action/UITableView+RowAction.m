//
//  UITableView+RowAction.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/2.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

/**
 运行时文档：
 http://www.cocoachina.com/ios/20160826/17422.html
 https://www.jianshu.com/p/44e20fd2efa8?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 https://www.cnblogs.com/xiao-love-meng/p/5757550.html
 
 https://www.jianshu.com/p/c8530fbd4168
 https://www.jianshu.com/p/779f36c21632
 
 http://www.cocoachina.com/ios/20171107/21078.html
 
 */

#import "UITableView+RowAction.h"
#import "UITableViewRowAction+FCCategory.h"
#import <objc/runtime.h>

@implementation UITableView (RowAction)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{//拦截代理方法
        Method setDelegate = class_getInstanceMethod(self.class, @selector(setDelegate:));
        Method __setDelegate = class_getInstanceMethod(self.class, @selector(__setDelegate:));
        method_exchangeImplementations(setDelegate, __setDelegate);
    });
}

- (void)__setDelegate:(id<UITableViewDelegate>)delegate{
/**----------------- willBeginEditingRowAtIndexPath ------------------*/
    SEL oldWillBeginEditingRow = @selector(tableView:willBeginEditingRowAtIndexPath:);
    SEL newWillBeginEditingRow = @selector(__tableView:willBeginEditingRowAtIndexPath:);
    //
    Method oldWillBeginEditingRowMethod = class_getInstanceMethod(delegate.class,oldWillBeginEditingRow);
    Method oldWillBeginEditingRowMethod_self = class_getInstanceMethod(self.class,oldWillBeginEditingRow);
    Method newWillBeginEditingRowMehod = class_getInstanceMethod(self.class, newWillBeginEditingRow);
    
    //未实现代理方法时，先添加代理方法
    BOOL isSuccess = class_addMethod(delegate.class, oldWillBeginEditingRow, class_getMethodImplementation(self.class, newWillBeginEditingRow), method_getTypeEncoding(newWillBeginEditingRowMehod));
    if (isSuccess) {//delegate 对象没有实现 oldWillBeginEditingRow 方法
        //将 delegate 对象添加的 newWillBeginEditingRow 方法用当前类的 oldWillBeginEditingRow 方法替换，用于调用：[self __tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
        class_replaceMethod(delegate.class, newWillBeginEditingRow, class_getMethodImplementation(self.class, oldWillBeginEditingRow), method_getTypeEncoding(oldWillBeginEditingRowMethod_self));
    }else{//若实现代理方法，则添加 newMethod 进行替换
        BOOL isVictory = class_addMethod(delegate.class, newWillBeginEditingRow, class_getMethodImplementation(delegate.class, oldWillBeginEditingRow), method_getTypeEncoding(oldWillBeginEditingRowMethod));
        if (isVictory) {
            class_replaceMethod(delegate.class, oldWillBeginEditingRow, class_getMethodImplementation(self.class, newWillBeginEditingRow), method_getTypeEncoding(newWillBeginEditingRowMehod));
        }
    }
    
/**----------------- willBeginEditingRowAtIndexPath ------------------*/
    SEL oldDidEndEditingRow = @selector(tableView:didEndEditingRowAtIndexPath:);
    SEL newDidEndEditingRow = @selector(__tableView:didEndEditingRowAtIndexPath:);
    //
    Method oldDidEndEditingRowMethod = class_getInstanceMethod(delegate.class, oldDidEndEditingRow);
    Method oldDidEndEditingRowMethod_self = class_getInstanceMethod(self.class, oldDidEndEditingRow);
    Method newDidEndEditingRowMethod = class_getInstanceMethod(self.class, newDidEndEditingRow);
    BOOL isSuccess1 = class_addMethod(delegate.class, oldDidEndEditingRow, class_getMethodImplementation(self.class, newDidEndEditingRow), method_getTypeEncoding(newDidEndEditingRowMethod));
    if (isSuccess1) {
        //调用 [self __tableView:tableView didEndEditingRowAtIndexPath:indexPath]; 方法时就执行 -tableView:willBeginEditingRowAtIndexPath: 方法。
        class_replaceMethod(delegate.class, newDidEndEditingRow, class_getMethodImplementation(self.class, oldDidEndEditingRow), method_getTypeEncoding(oldDidEndEditingRowMethod_self));
    }else{
        BOOL isVictory = class_addMethod(delegate.class, newDidEndEditingRow, class_getMethodImplementation(delegate.class, oldDidEndEditingRow), method_getTypeEncoding(oldDidEndEditingRowMethod));
        if (isVictory) {
            class_replaceMethod(delegate.class, oldDidEndEditingRow, class_getMethodImplementation(self.class, newDidEndEditingRow), method_getTypeEncoding(newDidEndEditingRowMethod));
        }
    }
    //调用源方法
    [self __setDelegate:delegate];
}




#pragma mark - 原始方法实现，tableView 未实现这些代理方法
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath{
    
}
#pragma mark - 自定义方法实现
- (void)__tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    unsigned int *cont = malloc(sizeof(unsigned int));
    Ivar *mer = class_copyIvarList([tableView class], cont);
    //进行遍历
    NSLog(@"%zd,\n%zd",cont,*cont);
    for (int i=0; i< *cont ; i++) {
        //通过移动指针进行遍历
        Ivar var = * (mer+i);
        //获取变量的名称
        const char * name = ivar_getName(var);
        //获取变量的类型
        const char * type = ivar_getTypeEncoding(var);
        NSLog(@"%s:%s\n",name,type);
    }
    if (@available(iOS 11.0,*)) {
        for (UIView *view in tableView.subviews) {
            if ([NSStringFromClass([view class]) isEqualToString:@"UISwipeActionPullView"]) {
                NSLog(@"------------------");
                NSLog(@"%@",NSStringFromCGRect(view.frame));
                NSLog(@"(%f,%f)",view.frame.origin.x,view.frame.origin.y);
                NSLog(@"(%f,%f)",view.frame.size.width,view.frame.size.height);
                NSLog(@"------------------");
                NSLog(@"%@",[self.delegate tableView:self editActionsForRowAtIndexPath:indexPath]);
                for (UIButton *actionBtn in view.subviews) {
                    //                    NSLog(@"%@",NSStringFromCGRect(actionBtn.frame));
                    //                    [actionBtn setTitle:@"111" forState:UIControlStateNormal];
                    //                    [actionBtn setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
                    //                    [actionBtn setBackgroundImage:[UIImage imageNamed:@"Image1"] forState:UIControlStateNormal];
                    UITableViewRowAction *rowAction = [actionBtn valueForKey:@"action"];
                    [actionBtn setAttributedTitle:[[NSAttributedString alloc]initWithString:rowAction.title attributes:@{NSForegroundColorAttributeName : rowAction.fc_textColor,NSFontAttributeName : rowAction.fc_font}] forState:UIControlStateNormal];
                    if (rowAction.fc_image) {
                        [actionBtn setImage:rowAction.fc_image forState:UIControlStateNormal];
                    }
                    if (rowAction.fc_backgroundImage) {
                        [actionBtn setBackgroundImage:rowAction.fc_backgroundImage forState:UIControlStateNormal];
                    }
                    if (rowAction.backgroundColor) {
                        actionBtn.backgroundColor = rowAction.backgroundColor;
                    }
                    
                }
                
            }
        }
    }else{
        
    }
    
    
    //调用原始方法
    [self __tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
}
- (void)__tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath{
    
    
    //调用原始方法
    [self __tableView:tableView didEndEditingRowAtIndexPath:indexPath];
}



@end
