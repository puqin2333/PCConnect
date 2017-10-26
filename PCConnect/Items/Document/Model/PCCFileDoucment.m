//
//  PCCFileDoucment.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/25.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCFileDoucment.h"

@implementation PCCFileDoucment

- (instancetype)init {
    if (self = [super init]) {
        self.muData = [NSMutableData data];
    }
    return self;
}

- (void)postFileDescirbeCmd:(NSString *)cmd {
    
    [[PCCSocketCmd shareInstance] sendCmd:cmd];
    [PCCSocketCmd shareInstance].cmdDelegate = self;
    
}



#pragma mark -- SocketDelegate

- (void)getCmdDataMessage:(NSData *)data {
    
    int a;
    if (data.length <= 4) {
        int i;
        [data getBytes: &i length: sizeof(i)];
        a = CFSwapInt32BigToHost((uint32_t)i);
        return;
    } else {;
        [self.muData appendData:data];
        NSDictionary *dict = @{@"data":self.muData};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendFile" object:nil userInfo:dict];
    }
}


@end
