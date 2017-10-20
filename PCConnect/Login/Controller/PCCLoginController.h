//
//  PCCLoginController.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/10.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCCLoginController : UIViewController

@property(nonatomic, strong) UITextField *usernameTextField; // 用户名输入
@property(nonatomic, strong) UITextField *passwordTextField;   // 密码输入
@property(nonatomic, assign) BOOL isOnLine;

@end
