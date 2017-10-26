//
//  PCCShootScreenVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/20.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCShootScreenVC.h"
#import "PCCSocketCmd.h"
#import "PCCCommandModel.h"
#import "NSString+SubString.h"
#import "PCCFileDataModel.h"
#import "PCCFileDoucment.h"

@interface PCCShootScreenVC ()<PCCSocketCmdDelegate>{
    unsigned long _fileSize;
}

@property(nonatomic, strong) NSMutableData *imageData;
@property(nonatomic, strong) UIImageView *shotImage;
@property(nonatomic, strong) UIActivityIndicatorView *activityView;
@property(nonatomic, strong) PCCFileDataModel *fileDataModel;
@property(nonatomic, strong) PCCFileDoucment *fileData;
@property(nonatomic ,copy) NSString *fileName;

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
    [self getPhoto];
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
    
    //初始化缓冲控件
    self.activityView = [[UIActivityIndicatorView alloc]
                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.frame = CGRectMake(0, 0, kScreenWidht / 6, kScreenWidht / 6);
    self.activityView.center = self.view.center;
    self.activityView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
}

- (void)getPhoto {
    
    self.fileDataModel = [[PCCFileDataModel alloc] init];
    [self.fileDataModel postFileDescirbeCmd:self.shootScreen];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataSource:) name:@"fileMessage" object:nil];
    
}

- (void)receiveFileData {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFileData:) name:@"sendFile" object:nil];
    
}

#pragma mark -- 通知
- (void)loadDataSource:(NSNotification *)notification {
    
    NSString * fileDescribeStr = notification.userInfo[@"fileMessage"];
    
    NSString *file = [NSString subString:fileDescribeStr FromElement:@"{" toElement:@"}"];
    NSDictionary *dict = [PCCCommandModel dictionaryWithJsonString:file];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",dict[@"fileName"],dict[@"fileType"]];
    _fileSize = [dict[@"fileSize"] unsignedLongValue];
    
    self.fileName = fileName;
    
    PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"" describe:fileDescribeStr isback:false];
    NSString *commandStr = [commandModel toJSONString];
    NSMutableString *mutStr = [NSMutableString stringWithString:commandStr];
    NSRange range = {0, mutStr.length};
    // 去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\\" withString:@"" options:NSLiteralSearch range:range];
    NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",FILEREADY,mutStr,END_FLAG];
    
    NSMutableString *mutStr1 = [NSMutableString stringWithString:cmdStr];
    NSRange range1 = {0, mutStr1.length};
    [mutStr1 replaceOccurrencesOfString:@"\"[" withString:@"[" options:NSLiteralSearch range:range1];
    NSRange range2 = {0, mutStr1.length};
    [mutStr1 replaceOccurrencesOfString:@"]\"" withString:@"]" options:NSLiteralSearch range:range2];
    
    self.fileData = [[PCCFileDoucment alloc] init];
    [self.fileData postFileDescirbeCmd:mutStr1];
    [self receiveFileData];
    
}

- (void)getFileData:(NSNotification *)notification {

    self.imageData = notification.userInfo[@"data"];
    
    
    if (self.imageData.length == _fileSize) {
        [self.activityView stopAnimating];
        [self createFile];
        self.shotImage.image = [UIImage imageWithData:self.imageData];
    }
}

#pragma mark - 解析数据并在沙盒中创建文件
- (void)createFile {
    // 获取 Documents 目录的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *pathStr = [NSString stringWithFormat:@"%@/%@", path, self.fileName];
    NSLog(@"pathStr--%@",pathStr);
    BOOL succeed = [self.imageData writeToFile:pathStr atomically:YES];
    
    if (succeed) {
        
        
    } else {
        [self showMessage:@"加载文件失败"];
    }
}

#pragma mark -- Target-Action

- (void)buttonAction {
   
    self.imageData = nil;
    
}

- (void)clickLeftBtn {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 单击放大功能
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
}

#pragma mark --ShowMessage
- (void)showMessage:(NSString *)string {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:string
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self clickLeftBtn];
    }];
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark --SocketDelegate

- (void)getCmdDataMessage:(NSData *)data {
    int a;
    if (data.length <= 4) {
        int i;
        [data getBytes: &i length: sizeof(i)];
        a = CFSwapInt32BigToHost((uint32_t)i);
        return;
    } else {
        NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"resultString -- %@",resultString);
//        NSString *sss = [NSString subString:resultString FromElement:@"[" toElement:@"]"];
//        NSDictionary *dict = @{@"fileMessage" : sss};
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"fileMessage" object:nil userInfo:dict];
    }
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
