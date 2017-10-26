//
//  PCCRemoteControlVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCRemoteControlVC.h"
#import "PCCIconView.h"
#import <Masonry.h>
#import "PCCLoginController.h"

@interface PCCRemoteControlVC (){
    BOOL _isOnline;
}

@property(nonatomic, strong) PCCIconView *iconView;

@property(nonatomic, strong) UIButton *onLineButton;
@property(nonatomic, strong) UIButton *offLineButton;

@end

@implementation PCCRemoteControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setConstraint];
}

- (void)setUI {
    
    self.iconView = [[PCCIconView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidht, kScreenHeight * 0.4)];
    [self.view addSubview:_iconView];
     
    UIButton *onlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    onlineButton.layer.cornerRadius = 6.0f;
    onlineButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:18.0f];
    [onlineButton setTitle:@"链接电脑" forState:UIControlStateNormal];
    [onlineButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.00f] forState:UIControlStateNormal];
    onlineButton.backgroundColor = [UIColor colorWithRed:0.00f green:0.76f blue:0.71f alpha:1.00f];
    [self.view addSubview:onlineButton];
    
    UIButton *offlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    offlineButton.layer.cornerRadius = 6.0f;
    offlineButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:18.0f];
    [offlineButton setTitle:@"断开电脑" forState:UIControlStateNormal];
    [offlineButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.00f] forState:UIControlStateNormal];
    offlineButton.backgroundColor = [UIColor colorWithRed:0.00f green:0.76f blue:0.71f alpha:1.00f];
    [self.view addSubview:offlineButton];
    
    self.onLineButton = onlineButton;
    self.offLineButton = offlineButton;
    
    // 添加 action
    [onlineButton addTarget:self action:@selector(setUpConnect) forControlEvents:(UIControlEventTouchUpInside)];
    [offlineButton addTarget:self action:@selector(setDownConnect) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setConstraint {
    
    [_onLineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_bottom).with.offset(kScreenHeight * 0.1);
        make.trailing.mas_equalTo(-kScreenWidht * 0.1);
        make.leading.mas_equalTo(kScreenWidht * 0.1);
        make.height.mas_equalTo(50 * kScreenRatio);
    }];
    
    [_offLineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_onLineButton.mas_bottom).with.offset(kScreenRatio * 30);
        make.trailing.mas_equalTo(-kScreenWidht * 0.1);
        make.leading.mas_equalTo(kScreenWidht * 0.1);
        make.height.mas_equalTo(50 * kScreenRatio);
    }];
}

// 与服务器建立连接
- (void)setUpConnect {
    
    if (_isOnline == NO) {
        
        PCCLoginController *loginVC = [[PCCLoginController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVC animated:YES completion:nil];
        _isOnline = [PCCSocketCmd shareInstance].isOnline;
    } else {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前已链接" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
}

// 与服务器断开连接
- (void)setDownConnect {
    _isOnline = NO;
    [PCCSocketCmd shareInstance].isOnline = NO;
    [PCCSocketCmd shareInstance].socket.userData = SocketOfflineByUser;
    [[PCCSocketCmd shareInstance] cutOffCmdSocket];
    [self refreshIconView];
}

// 更新头像信息
- (void)refreshIconView {
    if (_isOnline == YES) {
        self.iconView.titleLabel.text = @"当前已连接";
        self.iconView.iconImageView.image = [UIImage imageNamed:@"image_online"];
    } else {
        self.iconView.titleLabel.text = @"未连接";
        self.iconView.iconImageView.image = [UIImage imageNamed:@"image"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    _isOnline = [PCCSocketCmd shareInstance].isOnline;
    [self refreshIconView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
