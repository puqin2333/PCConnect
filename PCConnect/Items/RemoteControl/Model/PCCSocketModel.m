//
//  PCCSocketModel.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/7.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCSocketModel.h"


@interface PCCSocketModel ()

@end

@implementation PCCSocketModel

+ (instancetype)shareInstance {
    static PCCSocketModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)socketConnectHost {
    _userOnline = NO;
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
    [self.socket writeData:cmdLength withTimeout:1 tag:1];
    [self.socket writeData:data withTimeout:1 tag:1];

//    [self.socket readDataToLength:4 withTimeout:-1 tag:1];
    [self.socket readDataWithTimeout:-1 tag:1];
}
#pragma mark -- AsyncSocketDelegate

// 连接成功回调
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"socket 连接成功！");
    // 每隔30s向服务器发送心跳包
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
//    /*
//     * 将定时器的消息发送到目标。
//     * 你可以使用这个方法来触发一个重复的计时器，而不会打断它的常规射击时间表。
//     * 如果定时器是不重复的，它会在发射后自动失效，即使它的预定的发射日期还没有到达。
//     */
    [self.connectTimer fire];
    [self longConnectToSocket];
}

// 重连
- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    NSLog(@"sorry the connect is failure %ld",sock.userData);
    if (sock.userData == SocketOfflineByServer) {
        // 服务器掉线，重连
        [self socketConnectHost];
    } else if (sock.userData == SocketOfflineByUser) {
        return;
    }
}

// 如果得到数据，会调用回调方法

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {

    NSLog(@"%@",data);
    NSString *recStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.resultString = recStr;
    NSLog(@"recStr -- %@",recStr);
    [self.socket readDataWithTimeout:-1 tag:1];
    
}


#pragma mark -- Action方法

- (void)longConnectToSocket {
    NSLog(@"1");
    if (_userOnline == NO) {
        // 将命令转换成字节流
        NSString *usename = self.username;
        NSString *password = self.password;
        NSString *loginStr = [NSString stringWithFormat:@"%@_%@_%@_%@",CONNECTED_TO_USER,usename,password,END_FLAG];
        NSData *data = [loginStr dataUsingEncoding:NSUTF8StringEncoding];
        
        /*
         * 规定先发送内容字节长度，再发送内容
         */
        int dateLength =CFSwapInt32BigToHost((uint32_t)data.length);// 需要转化大小端
        NSData *cmdLength = [NSData dataWithBytes:&dateLength length:sizeof(dateLength)];
        [self.socket writeData:cmdLength withTimeout:1 tag:1];
        [self.socket writeData:data withTimeout:1 tag:1];
        
        [self.socket readDataToLength:4 withTimeout:-1 tag:1];
        _userOnline = YES;
    } else {

    }
}


@end