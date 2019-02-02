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
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //
    [self setupLayout];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 初始化
- (void)setupUI{
    [self.view addSubview:self.inputActionView];
}
- (void)setupLayout{
    [self.inputActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(50));
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
