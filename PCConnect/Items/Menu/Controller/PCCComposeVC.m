//
//  PCCComposeVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCComposeVC.h"
#import "PCCItemButton.h"
#import "PCCSocketCmd.h"
#import "PCCMenuItem.h"
#import "PCCQuiteCmdVC.h"
#import "PCCMouseControlVC.h"
#import "PCCDiskDocumentVC.h"
#import "PCCSearchVC.h"
#import "PCCShootScreenVC.h"
#import "PCCNavgationController.h"
#import "PCCTabBarController.h"
#import "PCCCommandModel.h"
#import "UIAlertController+show.h"


@interface PCCComposeVC ()

@property(nonatomic, strong) NSMutableArray  *btnArray;
@property(nonatomic, strong) NSTimer         *time;
@property(nonatomic, strong) UIView        *sliderView;
@property(nonatomic, strong) UISlider      *slider;
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

    [self setUI];
    
}

- (void)setUI {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, kScreenHeight - 40, kScreenWidht, 40);
    backButton.titleLabel.textColor =[UIColor colorWithRed:0.43f green:0.80f blue:0.98f alpha:1.00f];
    [self.view addSubview:backButton];
    [backButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addBtn];
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(upData) userInfo:nil repeats:YES];
    
    UIView *sliderView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidht * 0.05, kScreenHeight * 0.15, kScreenWidht * 0.9, kScreenHeight * 0.08)];
    sliderView.backgroundColor = [UIColor colorWithRed:0.25f green:0.33f blue:0.35f alpha:0.60f];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(kScreenWidht * 0.05, 0, kScreenWidht * 0.8, kScreenHeight * 0.08)];
    slider.minimumValue = 0;
    slider.maximumValue = 10;
    slider.value = (slider.minimumValue + slider.maximumValue) / 2;
    self.slider = slider;
    self.sliderView = sliderView;
    
}

#pragma mark -- button的实现
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
//        [btn addTarget:self action:@selector(btnClickT:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArray addObject:btn];
        [self.view addSubview:btn];
    }
}


#pragma mark --Target-Action
- (void)btnClick:(UIButton *)btn {
    
    
    if ([PCCSocketCmd shareInstance].isOnline == NO) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前未连接，请连接后重试！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        switch (btn.tag) {
                
            case 0:{
                PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"-1" describe:@"" isback:true];
                NSString *commandStr = [commandModel toJSONString];
                NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
                [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
                
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要关机" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *oKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"0" describe:@"" isback:false];
                    NSString *commandStr = [commandModel toJSONString];
                    NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
                    [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
                }];
                [alertVC addAction:cancelAction];
                [alertVC addAction:oKAction];
                [self presentViewController:alertVC animated:YES completion:nil];
            };
                break;
                
            case 1:{
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
                [formatter setDateFormat:@"YYYYMMddHHmmss"];
                NSDate *nowDate = [NSDate date];
                NSString *nowtimeStr = [formatter stringFromDate:nowDate];
                
                PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"2" describe:nowtimeStr isback:false];
                NSString *commandStr = [commandModel toJSONString];
                NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
                [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
                
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否回传截屏" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertVC addAction:cancelAction];
                
                UIAlertAction *oKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                        PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"2" describe:nowtimeStr isback:true];
                        NSString *commandStr = [commandModel toJSONString];
                        NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
                        
                        PCCShootScreenVC *shootScreenVC = [[PCCShootScreenVC alloc] init];
                        shootScreenVC.shootScreen = cmdStr;
                        [[self presentingVC].navigationController pushViewController:shootScreenVC animated:NO];
                    }];
                }];
                [alertVC addAction:oKAction];
                [self presentViewController:alertVC animated:YES completion:nil];
            };
                break;
                
            case 2:{
    
                PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"-1" describe:@"" isback:true];
                NSString *commandStr = [commandModel toJSONString];
                NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
                [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    
                    PCCMouseControlVC *mouseVC = [[PCCMouseControlVC alloc] init];
                    [[self presentingVC].navigationController pushViewController:mouseVC animated:NO];
                }];
                }
                break;
                
            case 3:{
                PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"4" describe:@"" isback:true];
                NSString *commandStr = [commandModel toJSONString];
                NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
                [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    PCCDiskDocumentVC   *diskDocumentVC = [[PCCDiskDocumentVC alloc] init];
                    [[self presentingVC].navigationController pushViewController:diskDocumentVC animated:NO];
                }];
            };
                break;
                
            case 4:{
                [self.sliderView addSubview:self.slider];
                [self.view addSubview:self.sliderView];
                [self.slider addTarget:self action:@selector(lightValueChanged:) forControlEvents:UIControlEventValueChanged];
               
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
                
            case 7:{
                
                [self.sliderView addSubview:self.slider];
                [self.view addSubview:self.sliderView];
                [self.slider addTarget:self action:@selector(voliceValueChanged:) forControlEvents:UIControlEventValueChanged];
                
            };
                
                break;
            case 8:{
                
            }
                
                break;
                
            default:
                break;
        }
    }
    

}
- (void)btnClickT:(UIButton *)btn {
    [UIView animateWithDuration:0.5 animations:^{
        btn.alpha = 1;
        btn.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)cancleBtnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// slider 的 action
- (void)lightValueChanged:(id)sender {
    
}

- (void)voliceValueChanged:(id)sender {
    
}



//获取当前屏幕显示的viewcontroller

- (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
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

// touch事件 -- 当点击空白处，slider移除

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.sliderView removeFromSuperview];
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
