//
//  PCCNoticeVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/25.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCNoticeVC.h"
#import "PCCSocketCmd.h"
#import "NSString+SubString.h"
#import "PCCCommandModel.h"
#import "PCCFileDataModel.h"
#import "PCCFileDoucment.h"

@interface PCCNoticeVC (){
    unsigned long _fileSize;
}

@property(nonatomic, copy) NSString *fileDescribeString;
@property(nonatomic, strong) PCCFileDataModel *fileDataModel;
@property(nonatomic, strong) PCCFileDoucment *fileData;
@property(nonatomic, copy) NSString *fileName;

@end

@implementation PCCNoticeVC

#pragma mark - 懒加载
- (UIProgressView *)progress {
    if (_progress == nil) {
        _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progress.frame = CGRectMake(0, kScreenHeight / 20 + kScreenHeight / 28, kScreenWidht, 0);
        _progress.trackTintColor = [UIColor whiteColor];
        _progress.progress = 0;
        _progress.transform = CGAffineTransformMakeScale(1.0f, 6.0f);
        _progress.progressTintColor = [UIColor colorWithRed:62 / 255.0 green:230 / 255.0 blue:110 / 255.0 alpha:1];
    }
    return _progress;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.01f green:0.76f blue:0.71f alpha:1.00f];
    self.muData = [NSMutableData data];
    [self setUI];
    [self getFileDescribe];
}

#pragma mark - 私有方法
- (void)setUI {
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 20 + kScreenHeight / 28,
                                                               kScreenWidht, kScreenHeight - kScreenHeight / 20)];
    [self.webView.layer setCornerRadius:5];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;             //自动对页面进行缩放以适应屏幕
    [self.view addSubview:self.webView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, kScreenHeight - 40, kScreenWidht, 40);
    backButton.titleLabel.textColor = [UIColor colorWithRed:0.43f green:0.80f blue:0.98f alpha:1.00f];
    [self.view addSubview:backButton];
    [backButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidht / 2 - kScreenWidht / 4, kScreenHeight / 28, kScreenWidht / 2, 23)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    //添加进度条
    [self.view addSubview:self.progress];
}

#pragma mark -- 自定义私有方法
- (void)getFileDescribe {
    
    self.fileDataModel = [[PCCFileDataModel alloc] init];
    [self.fileDataModel postFileDescirbeCmd:self.fileString];
    
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
    self.titleLabel.text = fileName;
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
    
    self.muData = notification.userInfo[@"data"];
    [self.progress setProgress:self.muData.length / (float)_fileSize animated:YES];
       
    if (self.muData.length == _fileSize) {
        NSLog(@"%lu", (unsigned long)self.muData.length);
        [self createFile];
        self.muData = nil;
    }
}

#pragma mark - 解析数据并在沙盒中创建文件
- (void)createFile {
    // 获取 Documents 目录的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *pathStr = [NSString stringWithFormat:@"%@/%@", path, self.fileName];
    NSLog(@"pathStr--%@",pathStr);
    BOOL succeed = [self.muData writeToFile:pathStr atomically:YES];
    
    if (succeed) {
        [self.progress removeFromSuperview];
        NSURL *url = [NSURL fileURLWithPath:pathStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    } else {
        [self showMessage:@"加载文件失败"];
    }
}

#pragma mark --ShowMessage
- (void)showMessage:(NSString *)string {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:string
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self cancleBtnClick];
    }];
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)cancleBtnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
