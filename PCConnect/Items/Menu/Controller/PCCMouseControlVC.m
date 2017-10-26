//
//  PCCMouseControlVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/13.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCMouseControlVC.h"
#import "PCCCommandModel.h"
#import "PCCSocketCmd.h"

@interface PCCMouseControlVC () <UIGestureRecognizerDelegate>{
    NSMutableDictionary *_pointPathDict;
}

@property(nonatomic, strong) UIView *touchView;
@property(nonatomic, assign) CGPoint location;
@property(nonatomic, assign) CGPoint doubleLocation;


@end

@implementation PCCMouseControlVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"鼠标控制";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self setUI];
    
}

- (void)setUI {
    
    UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidht * 0.1, kScreenHeight * 0.1, kScreenWidht * 0.8, kScreenHeight * 0.6)];
    touchView.backgroundColor = [UIColor colorWithRed:120 / 255.0 green:115 / 255.0 blue:115 / 255.0 alpha:1];
    touchView.layer.cornerRadius = 6.0f;
    touchView.layer.borderWidth  = 3.0f;
    touchView.layer.borderColor = [UIColor colorWithRed:151 / 255.0 green:151 / 255.0
                                                    blue:151 / 255.0 alpha:1].CGColor;
    self.touchView = touchView;
    [self.view addSubview:_touchView];
    
    UIButton *leftClickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftClickButton.frame = CGRectMake(kScreenWidht * 0.1, kScreenHeight * 0.7, kScreenWidht * 0.4, kScreenHeight * 0.08);
    leftClickButton.backgroundColor = [UIColor colorWithRed:120 / 255.0 green:115 / 255.0 blue:115 / 255.0 alpha:1];
    [leftClickButton.layer setCornerRadius:5];
    [leftClickButton.layer setBorderWidth:3];
    [leftClickButton.layer setBorderColor:[UIColor colorWithRed:151 / 255.0 green:151 / 255.0
                                                           blue:151 / 255.0 alpha:1].CGColor];
    [leftClickButton setTitle:@"左键" forState:UIControlStateNormal];
    [leftClickButton setTintColor:[UIColor whiteColor]];
    [leftClickButton addTarget:self action:@selector(leftClickButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftClickButton];
    
    UIButton *rightClickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightClickButton.frame = CGRectMake(kScreenWidht * 0.5, kScreenHeight * 0.7, kScreenWidht * 0.4, kScreenHeight * 0.08);
    rightClickButton.backgroundColor = [UIColor colorWithRed:120 / 255.0 green:115 / 255.0 blue:115 / 255.0 alpha:1];
    [rightClickButton.layer setCornerRadius:5];
    [rightClickButton.layer setBorderWidth:3];
    [rightClickButton.layer setBorderColor:[UIColor colorWithRed:151 / 255.0 green:151 / 255.0
                                                            blue:151 / 255.0 alpha:1].CGColor];
    [rightClickButton setTitle:@"右键" forState:UIControlStateNormal];
    [rightClickButton setTintColor:[UIColor whiteColor]];
    [rightClickButton addTarget:self action:@selector(rightClickButtonAction)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightClickButton];
    
    [self setGresture];
   
}

- (void)setGresture {
    // 单击手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftClickButtonAction)];
    singleTap.numberOfTapsRequired = 1;
    [self.touchView addGestureRecognizer:singleTap];
    
    // 双指单击
    UITapGestureRecognizer *doubleFingelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClickButtonAction)];
    doubleFingelTap.numberOfTapsRequired = 1;
    doubleFingelTap.numberOfTouchesRequired = 2;
    [self.touchView addGestureRecognizer:doubleFingelTap];
    
    // 拖动手势
    UIPanGestureRecognizer *panGresture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTap:)];
    panGresture.delegate = self;
    panGresture.minimumNumberOfTouches = 1;
    panGresture.maximumNumberOfTouches = 10;
    [self.touchView addGestureRecognizer:panGresture];
    
    //双指拖动手势
    UIPanGestureRecognizer *doublePanTap = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(doublePanTap:)];
    doublePanTap.minimumNumberOfTouches = 2;
    doublePanTap.maximumNumberOfTouches = 2;
    [self.touchView addGestureRecognizer:doublePanTap];
    
    
}


#pragma mark -- Target-Action

- (void)leftClickButtonAction {

    NSDictionary *pointWayPath = @{@"0" : @0 };
    PCCPointModel *pointModel = [[PCCPointModel alloc] initWithTouchClick:true singleClick:true doubleClick:false rightClick:false map:pointWayPath];
    NSString *pointJsonString = [pointModel toJSONString];
    PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"3" describe:pointJsonString isback:false];
    NSString *commandStr = [commandModel toJSONString];
    NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
    [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
}

- (void)rightClickButtonAction {
    
    NSDictionary *pointWayPath = @{@"0" : @0 };
    PCCPointModel *pointModel = [[PCCPointModel alloc] initWithTouchClick:true singleClick:false doubleClick:false rightClick:true map:pointWayPath];
    NSString *pointJsonString = [pointModel toJSONString];
    PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"3" describe:pointJsonString isback:false];
    NSString *commandStr = [commandModel toJSONString];
    NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
    [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
}

- (void)doubleClickButtonAction {
    
    NSDictionary *pointWayPath = @{@"0" : @0 };
    PCCPointModel *pointModel = [[PCCPointModel alloc] initWithTouchClick:true singleClick:false doubleClick:true rightClick:false map:pointWayPath];
    NSString *pointJsonString = [pointModel toJSONString];
    PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"3" describe:pointJsonString isback:false];
    NSString *commandStr = [commandModel toJSONString];
    NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
    [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
}


#pragma mark - 手势监测函数

//static float scale = 0;
- (void)panTap:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        self.location = [panGesture locationInView:panGesture.view.superview];
    }
    CGPoint afterLocation = [panGesture locationInView:panGesture.view.superview];
    NSString *offsetX = [NSString stringWithFormat:@"%d",(int)(afterLocation.x - self.location.x)/5];
    NSDictionary *pointPathDict = @{
                                    offsetX  :  @((int)(afterLocation.y - self.location.y)/5)
                                    };
    
    PCCPointModel *pointModel = [[PCCPointModel alloc] initWithTouchClick:false singleClick:false doubleClick:false rightClick:false map:pointPathDict];
    NSString *pointJsonString = [pointModel toJSONString];
    PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"3" describe:pointJsonString isback:false];
    NSString *commandStr = [commandModel toJSONString];
    NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
    [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
}
// 58092
- (void)doublePanTap:(UIPanGestureRecognizer *)doublePanTap {
    if (doublePanTap.state == UIGestureRecognizerStateBegan) {
        self.doubleLocation = [doublePanTap locationInView:doublePanTap.view.superview];
    } else if (doublePanTap.state == UIGestureRecognizerStateEnded) {
        CGPoint afterLocation = [doublePanTap locationInView:doublePanTap.view.superview];
        if (afterLocation.y - self.doubleLocation.y > 0) {
//            XYQCommomModel *comm = [[XYQCommomModel alloc] initWithFlag:@"3" Msg:@"0,0,WheelDown,"];
//            NSString *sendStr = [comm toJSONString];
//            NSString *comStr = [NSString stringWithFormat:@"XiYou#%@",sendStr];
//
//            [self.socketServer.socketCmd sendMessage:comStr];
        } else if(afterLocation.y - self.doubleLocation.y < 0){
//            XYQCommomModel *comm = [[XYQCommomModel alloc] initWithFlag:@"3" Msg:@"0,0,WheelUp,"];
//            NSString *sendStr = [comm toJSONString];
//            NSString *comStr = [NSString stringWithFormat:@"XiYou#%@",sendStr];
//
//            [self.socketServer.socketCmd sendMessage:comStr];
        }
    }
}

//navigationBar
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
