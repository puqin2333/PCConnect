//
//  PCCShootScreenVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/20.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCShootScreenVC.h"

@interface PCCShootScreenVC ()

@property(nonatomic, strong) NSMutableData *imageData;
@property(nonatomic, strong) UIImageView *shotImage;
@property(nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation PCCShootScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"电脑截屏";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self setUI];
}


- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.shotImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 104, kScreenWidht - 40, 200)];
    self.shotImage.backgroundColor = [UIColor lightGrayColor];
    self.shotImage.userInteractionEnabled = YES;
    [self.view addSubview:self.shotImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.shotImage addGestureRecognizer:tap];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(kScreenWidht / 2.0 - 30, 350, 60, 60);
//    [button setTitle:@"截屏" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"截屏"] forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //初始化缓冲控件
    self.activityView = [[UIActivityIndicatorView alloc]
                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.frame = CGRectMake(0, 0, kScreenWidht / 6, kScreenWidht / 6);
    self.activityView.center = self.view.center;
    self.activityView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.activityView];
    
}

#pragma mark -- Target-Action

- (void)buttonAction {
   
    self.imageData = nil;
    
}

#pragma mark - 单击放大功能
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
}

- (void)clickLeftBtn {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
