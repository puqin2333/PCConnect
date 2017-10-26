//
//  PCCSocketFile.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/24.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCSocketFile.h"

@implementation PCCSocketFile

// 发送命令指令
static NSString* const CONNECTED_TO_USER = @"|CONNECTED@TO@USER|";
static NSString* const COMMAND = @"|COMMAND|";
static NSString* const END_FLAG = @"@@|END@FLAG|@@";
static NSString* const GETFILE = @"|GET@FILE|";
static NSString* const FILELIST = @"|FILE@LIST@FLAG|";
static NSString* const FILEREADY = @"|FILE@READY|";
static NSString* const FILENOTREADY = @"|FILE@NOT@READY|_|END@FLAG|";

static NSString* const socketHost = @"139.199.20.248";
static UInt16 const port = 10086;
enum{
    SocketOfflineByServer, // 服务器掉线
    SocketOfflineByUser,   // 用户主动cut
};

+ (instancetype)shareInstance {
    static PCCSocketFile *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
        sharedInstance.isOnline = NO;
    });
    return sharedInstance;
    
}

- (void)socketConnectHost {
    _userOnline = NO;
    
    //配置socket的运行循环模式
    [self.socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    
    self.socket = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *error = nil;
    [self.socket connectToHost:socketHost onPort:port withTimeout:3 error:&error];
}

- (void)cutOffCmdSocket {
    NSLog(@"用户切断连接！");
    self.socket.userData = SocketOfflineByUser; // 声明是由用户主动切断的
    
    [self.connectTimer invalidate];
    
    [self.socket disconnect];
}

- (void)sendCmd:(NSString *)cmdString {
    
    NSData *data = [cmdString dataUsingEncoding:NSUTF8StringEncoding];
    int dateLength =CFSwapInt32BigToHost((uint32_t)data.length);// 需要转化大小端
    NSData *cmdLength = [NSData dataWithBytes:&dateLength length:sizeof(dateLength)];
    [self.socket writeData:cmdLength withTimeout:-1 tag:1];
    [self.socket writeData:data withTimeout:-1 tag:1];
    
    //    [self.socket readDataToLength:4 withTimeout:-1 tag:1];
    [self.socket readDataWithTimeout:-1 tag:1];
    //    [self onSocket:self.socket didWriteDataWithTag:1];
}

- (void)sendFile:(NSString *)fileMessage {
    
    NSData *data = [fileMessage dataUsingEncoding:NSUTF8StringEncoding];
    int dateLength =CFSwapInt32BigToHost((uint32_t)data.length);// 需要转化大小端
    NSData *cmdLength = [NSData dataWithBytes:&dateLength length:sizeof(dateLength)];
    [self.socket writeData:cmdLength withTimeout:-1 tag:1];
    [self.socket writeData:data withTimeout:-1 tag:1];
    
    
    [self.socket readDataWithTimeout:-1 tag:1];
}


#pragma mark -- AsyncSocketDelegate

// 连接成功回调
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"socket 连接成功！");
    // 每隔30s向服务器发送心跳包
//    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
//    //    /*
//    //     * 将定时器的消息发送到目标。
//    //     * 你可以使用这个方法来触发一个重复的计时器，而不会打断它的常规射击时间表。
//    //     * 如果定时器是不重复的，它会在发射后自动失效，即使它的预定的发射日期还没有到达。
//    //     */
//    [self.connectTimer fire];
    [self longConnectToSocket];
}

// 重连
- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    if (sock.userData == SocketOfflineByServer) {
        // 服务器掉线，重连
        [self socketConnectHost];
    } else if (sock.userData == SocketOfflineByUser) {
        return;
    }
}

////发送消息成功之后回调
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    [self.socket readDataWithTimeout:-1 tag:1];
}

// 如果得到数据，会调用回调方法
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {

    [self.fileDelegate getFileDataMessage:data];
    [self.socket readDataWithTimeout:-1 tag:1];
    
}


#pragma mark --Target-Action方法

- (void)longConnectToSocket {
        // 将命令转换成字节流
        NSString *usename = self.username;
        NSString *password = self.password;
        NSString *loginStr = [NSString stringWithFormat:@"%@_%@_%@_%@",CONNECTED_TO_USER,usename,password,END_FLAG];
        NSData *data = [loginStr dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"login--%@",loginStr);
        /*
         * 规定先发送内容字节长度，再发送内容
         */
        int dateLength =CFSwapInt32BigToHost((uint32_t)data.length);// 需要转化大小端
        NSData *cmdLength = [NSData dataWithBytes:&dateLength length:sizeof(dateLength)];
        [self.socket writeData:cmdLength withTimeout:1 tag:1];
        [self.socket writeData:data withTimeout:1 tag:1];
        
        [self.socket readDataToLength:4 withTimeout:-1 tag:1];
        _userOnline = YES;
}


@end
