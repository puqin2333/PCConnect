//
//  PCCTabBar.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/28.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCTabBar.h"

@interface PCCTabBar ()

@property(nonatomic,weak)UIButton *publishButton;

@end

@implementation PCCTabBar
// 自定义初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (UIButton *)publishButton {
    if (self.publishButton == nil) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
        [publishButton addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    int buttonIndex = 0;
    for (UIView *subView in [self subviews]) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            buttonX = buttonIndex * buttonW;
            if (buttonIndex >= 2) {
                buttonX += buttonW;
            }
            subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            buttonIndex ++;
        }
    }
    //中间添加按钮布局
    self.publishButton.backgroundColor = [UIColor brownColor];
    self.publishButton.frame = CGRectMake(0, 0, self.frame.size.width/5 - 20, self.frame.size.height + 20);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    self.publishButton.layer.cornerRadius = _publishButton.frame.size.width/2;
    
}

- (void)pushClick {
    
}

@end
