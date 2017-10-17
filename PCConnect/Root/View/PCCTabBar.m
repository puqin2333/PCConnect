//
//  PCCTabBar.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/28.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCTabBar.h"
#import "PCCComposeVC.h"
#import "PCCMenuItem.h"
#import "PCCComposeView.h"
#import "PCCNavgationController.h"

@interface PCCTabBar ()

@property(nonatomic, weak) UIButton *publishButton;

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
    if (_publishButton == nil) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
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
    self.publishButton.backgroundColor = [UIColor colorWithRed:0.00f green:0.76f blue:0.71f alpha:1.00f];
    self.publishButton.frame = CGRectMake(0, 0, self.frame.size.width/5 - 20, self.frame.size.height - 6);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (void)pushClick {
    
    PCCComposeVC *compopseVC = [[PCCComposeVC alloc] init];
//    PCCComposeView *compose = [[PCCComposeView alloc] init];
    PCCMenuItem *item1 = [PCCMenuItem itemWithTitle:@"电源" image:[UIImage imageNamed:@"电源"]];
    PCCMenuItem *item2 = [PCCMenuItem itemWithTitle:@"截屏" image:[UIImage imageNamed:@"截屏"]];
    PCCMenuItem *item3 = [PCCMenuItem itemWithTitle:@"鼠标" image:[UIImage imageNamed:@"鼠标"]];
    PCCMenuItem *item4 = [PCCMenuItem itemWithTitle:@"电脑盘符" image:[UIImage imageNamed:@"电脑盘符"]];
    PCCMenuItem *item5 = [PCCMenuItem itemWithTitle:@"亮度" image:[UIImage imageNamed:@"亮度"]];
    PCCMenuItem *item6 = [PCCMenuItem itemWithTitle:@"快捷工具" image:[UIImage imageNamed:@"快捷工具"]];
    PCCMenuItem *item7 = [PCCMenuItem itemWithTitle:@"搜索" image:[UIImage imageNamed:@"搜索"]];
    PCCMenuItem *item8 = [PCCMenuItem itemWithTitle:@"音量" image:[UIImage imageNamed:@"音量"]];
    PCCMenuItem *item9 = [PCCMenuItem itemWithTitle:@"语音" image:[UIImage imageNamed:@"语音"]];

//    PCCNavgationController *nav = [[PCCNavgationController alloc] initWithRootViewController:compopseVC];
    compopseVC.itemArray = @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
    
    compopseVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.owner.definesPresentationContext = YES;

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:compopseVC animated:YES completion:nil];
    
//    [self.owner presentViewController:compopseVC animated:YES completion:nil];
//
//    compose.itemArray = @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
//    compose.frame = CGRectMake(0, 0, kScreenWidht, kScreenHeight);
//    compose.owner = self.owner;
//    [self.owner.view addSubview:compose];
//    NSLog(@"class is %@",self.owner);
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
