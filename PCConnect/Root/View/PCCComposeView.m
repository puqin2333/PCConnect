//
//  PCCComposeView.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/14.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCComposeView.h"
#import "PCCItemButton.h"
#import "PCCSocketModel.h"
#import "PCCMenuItem.h"
#import "NSString+PCCDictToJSON.h"
#import "PCCQuiteCmdVC.h"
#import "PCCMouseControlVC.h"
#import "PCCDiskDocumentVC.h"
#import "PCCNavgationController.h"

@implementation PCCComposeView {
    NSMutableArray  *_btnArray;
    NSTimer         *_time;
    int              _buttonNum;

}

- (NSMutableArray *)btnArray {
    
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSArray *)itemArray {
    if (_itemArray == nil) {
        PCCMenuItem *item1 = [PCCMenuItem itemWithTitle:@"电源" image:[UIImage imageNamed:@"电源"]];
        PCCMenuItem *item2 = [PCCMenuItem itemWithTitle:@"截屏" image:[UIImage imageNamed:@"截屏"]];
        PCCMenuItem *item3 = [PCCMenuItem itemWithTitle:@"鼠标" image:[UIImage imageNamed:@"鼠标"]];
        PCCMenuItem *item4 = [PCCMenuItem itemWithTitle:@"电脑盘符" image:[UIImage imageNamed:@"电脑盘符"]];
        PCCMenuItem *item5 = [PCCMenuItem itemWithTitle:@"亮度" image:[UIImage imageNamed:@"亮度"]];
        PCCMenuItem *item6 = [PCCMenuItem itemWithTitle:@"快捷工具" image:[UIImage imageNamed:@"快捷工具"]];
        PCCMenuItem *item7 = [PCCMenuItem itemWithTitle:@"搜索" image:[UIImage imageNamed:@"搜索"]];
        PCCMenuItem *item8 = [PCCMenuItem itemWithTitle:@"音量" image:[UIImage imageNamed:@"音量"]];
        PCCMenuItem *item9 = [PCCMenuItem itemWithTitle:@"语音" image:[UIImage imageNamed:@"语音"]];
         self.itemArray = @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
    }
    return _itemArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, kScreenHeight - 40, kScreenWidht, 40);
    backButton.titleLabel.textColor =[UIColor colorWithRed:0.43f green:0.80f blue:0.98f alpha:1.00f];
    [self addSubview:backButton];
    [backButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addBtn];
    
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(upData) userInfo:nil repeats:YES];
}

- (void)upData {
    
    if (_buttonNum == _btnArray.count) {
        [_time invalidate];
        return;
    }
    UIButton *btn = _btnArray[_buttonNum];
    btn.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    _buttonNum ++;
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
        
        btn.transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btnClickT:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArray addObject:btn];
        [self addSubview:btn];
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
        };
            
            break;
        case 4:{
            
        };
            
            break;
        case 5:{
            PCCQuiteCmdVC *fastCmdVC = [[PCCQuiteCmdVC alloc] init];
            NSLog(@"%@",self.owner);
            [self.owner.navigationController pushViewController:fastCmdVC animated:YES];
//            [self removeFromSuperview];
        };
            
            break;
        case 6:
            
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
    [self removeFromSuperview];

}


@end
