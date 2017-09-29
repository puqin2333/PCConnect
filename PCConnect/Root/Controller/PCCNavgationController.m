//
//  PCCNavgationController.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/28.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCNavgationController.h"

@interface PCCNavgationController ()

@end

@implementation PCCNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 关闭高斯模糊
    [UINavigationBar appearance].translucent = NO;
    
    //去除导航栏的返回按钮的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:93/255.0 green:201/255.0 blue:241/25.0 alpha:1.0]];
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor colorWithRed:74 / 255.0 green:74 / 255.0 blue:74 / 255.0 alpha:1], NSFontAttributeName:[UIFont systemFontOfSize:17.f]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    
    // 设置 UINavagationBar 的背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:93/255.0 green:188/255.0 blue:208.0/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
