//
//  PCCTabBarController.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/28.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCTabBarController.h"
#import "PCCNavgationController.h"

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
    nav.tabBarItem.selectedImage = selectImage;
    nav.tabBarItem.title = itemTitle;
    nav.title = itemTitle;
    
    self.tabBar.tintColor = [UIColor colorWithRed:202/255.0
                                            green:193/255.0
                                             blue:104/255.0
                                            alpha:1.0];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:202/255.0 green:193/255.0 blue:104/255.0 alpha:1.0],
                                             NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:1.0]
                                             } forState:UIControlStateSelected];
    [self addChildViewController:nav];
}

- (void)setItems {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
