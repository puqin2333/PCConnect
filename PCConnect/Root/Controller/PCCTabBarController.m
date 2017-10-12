//
//  PCCTabBarController.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/28.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCTabBarController.h"
#import "PCCNavgationController.h"
#import "PCCTabBar.h"
#import "PCCRemoteControlVC.h"
#import "PCCTaskVC.h"
#import "PCCDocumentVC.h"
#import "PCCSettingVC.h"

@interface PCCTabBarController ()

@end

@implementation PCCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setItems];
}

- (void)addChildViewController:(UIViewController *)childController
                   normalImage:(UIImage *) normalImage
                   selectImage:(UIImage *) selectImage
                         title:(NSString *) itemTitle {
    PCCNavgationController *nav = [[PCCNavgationController alloc] initWithRootViewController:childController];
    nav.tabBarItem.image = normalImage;
    UIImage *select = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = select;
    nav.tabBarItem.title = itemTitle;
    childController.title = itemTitle;
    
    self.tabBar.tintColor = [UIColor colorWithRed:0.43f green:0.80f blue:0.98f alpha:1.00f];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.43f green:0.80f blue:0.98f alpha:1.00f],
                                             NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:1.0]
                                             } forState:UIControlStateSelected];
    [self addChildViewController:nav];
}

- (void)setItems {
    
    PCCRemoteControlVC *remoteControl = [[PCCRemoteControlVC alloc] init];
    [self addChildViewController:remoteControl normalImage:[UIImage imageNamed:@"远程控制"] selectImage:[UIImage imageNamed:@"远程控制"] title:@"远程"];
    
    PCCTaskVC *taskVC = [[PCCTaskVC alloc] init];
    [self addChildViewController:taskVC normalImage:[UIImage imageNamed:@"任务"] selectImage:[UIImage imageNamed:@"任务"] title:@"传输"];
    
    PCCDocumentVC *document = [[PCCDocumentVC alloc] init];
    [self addChildViewController:document normalImage:[UIImage imageNamed:@"文件"] selectImage:[UIImage imageNamed:@"文件"] title:@"管理"];
    
    PCCSettingVC *setting = [[PCCSettingVC alloc] init];
    [self addChildViewController:setting normalImage:[UIImage imageNamed:@"设置"] selectImage:[UIImage imageNamed:@"设置"] title:@"设置"];
    //     使用KVC替换原来的tabBar
    [self setValue:[[PCCTabBar alloc]init] forKeyPath:@"tabBar"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
