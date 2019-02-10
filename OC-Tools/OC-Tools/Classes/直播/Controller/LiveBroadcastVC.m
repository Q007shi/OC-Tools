//
//  LiveBroadcastVC.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/1/7.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "LiveBroadcastVC.h"
#import "InputActionView.h"

@interface LiveBroadcastVC ()

/** <#aaa#> */
@property(nonatomic,strong)InputActionView *inputActionView;

@end

@implementation LiveBroadcastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"直播间";
    //
    [self setupUI];
    [self setupLayout];
    NSLog(@"%f",k_bottomHeight);
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 初始化
- (void)setupUI{
    [self.view addSubview:self.inputActionView];
}
- (void)setupLayout{
    WEAKSELF
    [self.inputActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-k_bottomHeight);
        make.height.equalTo(@(50));
    }];
}

#pragma mark - 键盘事件监听
- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    NSLog(@"%@",dic);
    CGRect keyboardRect  = [dic[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    CGFloat duration = [dic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    WEAKSELF
    [UIView animateWithDuration:duration animations:^{
        [weakSelf.inputActionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(-keyboardRect.size.height);
        }];
    }];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    CGFloat duration = [dic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    WEAKSELF
    [UIView animateWithDuration:duration animations:^{
        [weakSelf.inputActionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(-k_bottomHeight);
        }];
    }];
}



#pragma mark - getter 方法
- (InputActionView *)inputActionView{
    if (!_inputActionView) {
        _inputActionView = [InputActionView new];
        _inputActionView.actionViewType = InputActionViewTypeEmoji | InputActionViewTypeCustomAction;
    }
    return _inputActionView;
}



@end
