//
//  InputActionView.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2019/2/2.
//  Copyright © 2019年 Ganggang Xie. All rights reserved.
//

#import "InputActionView.h"

#define InputActionView_SPACE 5

@interface InputActionView ()

/** 录段语音 */
@property(nonatomic,strong)UIButton *audioBtn;
/** <#aaa#> */
@property(nonatomic,strong)UIButton *audioActionBtn;
/** 文本输入 */
@property(nonatomic,strong)UITextView *inputTextView;
/** 表情 */
@property(nonatomic,strong)UIButton *emojiBtn;
/** 自定义功能 */
@property(nonatomic,strong)UIButton *customActionBtn;

/** <#aaa#> */
@property(nonatomic,assign)CGFloat buttonHeight;

@end

@implementation InputActionView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.buttonHeight = frame.size.height - 2*InputActionView_SPACE;
        self.backgroundColor = [UIColor whiteColor];
        _actionViewType = InputActionViewTypeAudio | InputActionViewTypeEmoji | InputActionViewTypeCustomAction;
        [self.inputTextView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    self.buttonHeight = self.bounds.size.height - 2*InputActionView_SPACE;
    WEAKSELF
    if ([self.subviews containsObject:self.audioBtn]) {
        [self.audioBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(weakSelf.buttonHeight)).priorityHigh();
        }];
    }
    if ([self.subviews containsObject:self.emojiBtn]) {
        [self.emojiBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(weakSelf.buttonHeight)).priorityHigh();
        }];
    }
    if ([self.subviews containsObject:self.customActionBtn]) {
        [self.customActionBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(weakSelf.buttonHeight)).priorityHigh();
        }];
    }
}

- (void)setupUI{
    [self addSubview:self.audioBtn];
    [self addSubview:self.audioActionBtn];
    [self addSubview:self.inputTextView];
    [self addSubview:self.emojiBtn];
    [self addSubview:self.customActionBtn];
}
- (void)setupLayout{
    WEAKSELF
    //发短语音功能
    [self.audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-InputActionView_SPACE);
        make.height.equalTo(@(weakSelf.buttonHeight)).priorityHigh();
        make.width.equalTo(weakSelf.audioBtn.mas_height);
    }];
    //有自定义功能按钮
    [self.customActionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-InputActionView_SPACE);
        make.height.equalTo(@(weakSelf.buttonHeight)).priorityHigh();
        make.width.equalTo(weakSelf.customActionBtn.mas_height);
    }];
    //表情按钮
    [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-InputActionView_SPACE);
        make.height.equalTo(@(weakSelf.buttonHeight)).priorityHigh();
        make.width.equalTo(weakSelf.emojiBtn.mas_height);
        make.right.equalTo(weakSelf.customActionBtn.mas_left).priority(500);
        //当没有 customActionBtn 时，使用优先级更低的约束
        make.right.equalTo(weakSelf).priority(300);
    }];
    //输入框
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.audioBtn.mas_right).priority(500).offset(InputActionView_SPACE);
        make.left.equalTo(self).priority(300).offset(InputActionView_SPACE);
        make.right.equalTo(self.emojiBtn.mas_left).priority(500).offset(-InputActionView_SPACE);
        make.right.equalTo(self.customActionBtn.mas_left).priority(400).offset(-InputActionView_SPACE);
        make.right.equalTo(self).priority(300).offset(-InputActionView_SPACE);
        make.top.equalTo(self).offset(InputActionView_SPACE);
        make.bottom.equalTo(self).offset(-InputActionView_SPACE);
        make.height.equalTo(@(self.bounds.size.height-10));
    }];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    WEAKSELF
    if (self.inputTextView.contentSize.height <= 40) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(50));
        }];
    }else if (self.inputTextView.contentSize.height <= 100){
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(weakSelf.inputTextView.contentSize.height));
        }];
    }else{
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(100));
        }];
    }
}

- (void)setActionViewType:(InputActionViewType)actionViewType{
    _actionViewType = actionViewType;
    if (actionViewType & InputActionViewTypeAudio) {
        if (![self.subviews containsObject:self.audioBtn]) {
            [self addSubview:self.audioBtn];
        }
    }else{
        [self.audioBtn removeFromSuperview];
    }
    //
    if (self.actionViewType & InputActionViewTypeCustomAction) {
        if (![self.subviews containsObject:self.customActionBtn]) {
            [self addSubview:self.customActionBtn];
        }
    }else{
        [self.customActionBtn removeFromSuperview];
    }
    //
    if (self.actionViewType & InputActionViewTypeEmoji) {
        if (![self.subviews containsObject:self.emojiBtn]) {
            [self addSubview:self.emojiBtn];
        }
    }else{
        [self.emojiBtn removeFromSuperview];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - 事件
- (void)audio:(UIButton *)audioBtn{
    audioBtn.selected = !audioBtn.selected;
}
- (void)audioAction:(UIButton *)audioActionBtn{
    
}
- (void)emojiAction:(UIButton *)emojiBtn{
    
    
}
- (void)customAction:(UIButton *)customActionBtn{
    
}

#pragma mark - getter 方法
- (UIButton *)audioBtn{
    if (!_audioBtn) {
        _audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_audioBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_audioBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_audioBtn addTarget:self action:@selector(audio:) forControlEvents:UIControlEventTouchUpInside];
        _audioBtn.backgroundColor = [UIColor fc_randomColor];
    }
    return _audioBtn;
}
- (UIButton *)audioActionBtn{
    if (!_audioActionBtn) {
        _audioActionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_audioActionBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_audioActionBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [_audioActionBtn addTarget:self action:@selector(audioAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _audioActionBtn;
}
- (UITextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [UITextView new];
        _inputTextView.backgroundColor = [UIColor fc_randomColor];
        _inputTextView.showsHorizontalScrollIndicator = NO;
    }
    return _inputTextView;
}
- (UIButton *)emojiBtn{
    if (!_emojiBtn) {
        _emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emojiBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_emojiBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_emojiBtn addTarget:self action:@selector(emojiAction:) forControlEvents:UIControlEventTouchUpInside];
        _emojiBtn.backgroundColor = [UIColor fc_randomColor];
    }
    return _emojiBtn;
}
- (UIButton *)customActionBtn{
    if (!_customActionBtn) {
        _customActionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_customActionBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_customActionBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [_customActionBtn addTarget:self action:@selector(customAction:) forControlEvents:UIControlEventTouchUpInside];
        _customActionBtn.backgroundColor = [UIColor fc_randomColor];
    }
    return _customActionBtn;
}

@end
