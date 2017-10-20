//
//  PCCSocketModel.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/7.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

// 发送命令指令
static NSString* const CONNECTED_TO_USER = @"|CONNECTED@TO@USER|";
static NSString* const COMMAND = @"|COMMAND|";
static NSString* const END_FLAG = @"@@|END@FLAG|@@";

static NSString* const socketHost = @"139.199.20.248";
static UInt16 const port = 10086;
enum{
    SocketOfflineByServer, // 服务器掉线
    SocketOfflineByUser,   // 用户主动cut
};

@interface PCCSocketModel : NSObject<AsyncSocketDelegate>

@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *resultString;
@property(nonatomic, assign) BOOL      userOnline;
@property(nonatomic, assign) BOOL      isOnline;
//@property(nonatomic, copy)   void      (^cmdConnectSuccess)();
//@property(nonatomic, copy)   void      (^cmdReceiveData)(NSDictionary *dic);
@property(nonatomic, strong) AsyncSocket    *socket;       // socket
@property(nonatomic, retain) NSTimer    *connectTimer;     // 计时器

+ (instancetype)shareInstance;
- (void)socketConnectHost; // socket连接
- (void)sendCmd:(NSString *)cmdString; // 控制命令
- (void)cutOffCmdSocket;   // 断开socket连接

@end
