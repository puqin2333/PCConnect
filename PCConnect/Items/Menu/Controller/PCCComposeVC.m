//
//  PCCComposeVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCComposeVC.h"
#import "PCCItemButton.h"
#import "PCCSocketModel.h"
#import "PCCMenuItem.h"
#import "NSString+PCCDictToJSON.h"
#import "PCCQuiteCmdVC.h"
#import "PCCMouseControlVC.h"
#import "PCCDiskDocumentVC.h"
#import "PCCSearchVC.h"
#import "PCCNavgationController.h"
#import "PCCTabBarController.h"


@interface PCCComposeVC ()

@property(nonatomic, strong) NSMutableArray  *btnArray;
@property(nonatomic, strong) NSTimer         *time;
@property(nonatomic, assign) int              buttonNum;

@end

@implementation PCCComposeVC

- (NSMutableArray *)btnArray {
    
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, kScreenHeight - 40, kScreenWidht, 40);
    backButton.titleLabel.textColor =[UIColor colorWithRed:0.43f green:0.80f blue:0.98f alpha:1.00f];
    [self.view addSubview:backButton];
    [backButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addBtn];
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(upData) userInfo:nil repeats:YES];
    
}

- (void)upData {
    
    if (self.buttonNum == self.btnArray.count) {
        [self.time invalidate];
        return;
    }
    UIButton *btn = self.btnArray[self.buttonNum];
    btn.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    self.buttonNum ++;
}

- (void)addBtn
{
    CGFloat btnWH = 100;
    int cloumn = 3;
    int curCloumn = 0;
    int curRow = 0;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width- cloumn * btnWH)/(cloumn + 1);
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat oriY = kScreenHeight * 0.4;
    
    PCCMenuItem *item = [[PCCMenuItem  alloc]init];
    
    for (int i = 0 ; i < self.itemArray.count; i++) {
        
        PCCItemButton *btn = [PCCItemButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        curCloumn = i % cloumn;
        curRow = i / cloumn;
        
        x = margin + curCloumn * (btnWH + margin);
        y = curRow * (btnWH +margin) + oriY;
        
        btn.frame = CGRectMake(x,y, btnWH, btnWH);
        item = self.itemArray[i];
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setTitle:item.title forState:UIControlStateNormal];
        
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btnClickT:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArray addObject:btn];
        [self.view addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn {
    
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
    
//    if ([PCCSocketModel shareInstance].userOnline == NO) {
//        NSLog(@"当前未上线，请先链接电脑！");
//    } else {
        switch (btn.tag) {
            case 0:{
                NSDictionary *cmdDict = @{@"describe" : @"",
                                          @"isback" : @true,
                                          @"type" : @"-1"};
                NSString *cmd = [NSString dictToJson:cmdDict];
                NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,cmd,END_FLAG];
                [[PCCSocketModel shareInstance] sendCmd:cmdStr];
            };
                
                break;
            case 1:{
//                NSDictionary *cmdDict = @{@"describe" : @"",
//                                          @"isback" : @true,
//                                          @"type" : @"4"};
//                NSString *cmd = [NSString dictToJson:cmdDict];
//                NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,cmd,END_FLAG];
//                [[PCCSocketModel shareInstance] sendCmd:cmdStr];
            };
                
                break;
            case 2:
                
                break;
            case 3:{
                NSDictionary *cmdDict = @{@"describe" : @"",
                                          @"isback" : @true,
                                          @"type" : @"4"};
                NSString *cmd = [NSString dictToJson:cmdDict];
                NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,cmd,END_FLAG];
                [[PCCSocketModel shareInstance] sendCmd:cmdStr];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    PCCDiskDocumentVC   *diskDocumentVC = [[PCCDiskDocumentVC alloc] init];
                    [[self presentingVC].navigationController pushViewController:diskDocumentVC animated:NO];
                }];
            };
                
                break;
            case 4:{
                
            };
                
                break;
            case 5:{
                [self dismissViewControllerAnimated:YES completion:^{
                    PCCQuiteCmdVC *fastCmdVC = [[PCCQuiteCmdVC alloc] init];
                    [[self presentingVC].navigationController pushViewController:fastCmdVC animated:NO];
                }];
            };
                
                break;
            case 6:{
                [self dismissViewControllerAnimated:YES completion:^{
                    PCCSearchVC *searchVC = [[PCCSearchVC alloc] init];
                    [[self presentingVC].navigationController pushViewController:searchVC animated:NO];
                }];
            };
                break;
            case 7:
                
                break;
            case 8:
                
                break;
            case 9:
                
                break;
            default:
                break;
//        }
    }
    

}
- (void)btnClickT:(UIButton *)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        btn.alpha = 1;
        btn.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)cancleBtnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"-----");
}

//获取当前屏幕显示的viewcontroller

- (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[PCCTabBarController class]]) {
        result = [(PCCTabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[PCCNavgationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
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
