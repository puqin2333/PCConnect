//
//  PCCSocketCmd.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/24.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

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


@protocol PCCSocketCmdDelegate <NSObject>

- (void)getCmdDataMessage:(NSData *)data;

@end


@interface PCCSocketCmd: NSObject<AsyncSocketDelegate>

@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *resultString;
@property(nonatomic, assign) BOOL      userOnline;
@property(nonatomic, assign) BOOL      isOnline;
@property(nonatomic, strong) AsyncSocket    *socket;       // socket
@property(nonatomic, retain) NSTimer    *connectTimer;     // 计时器
@property(nonatomic, weak) id <PCCSocketCmdDelegate> cmdDelegate;


+ (instancetype)shareInstance;
- (void)socketConnectHost; // socket连接
- (void)sendCmd:(NSString *)cmdString; // 控制命令
- (void)cutOffCmdSocket;   // 断开socket连接

@end
