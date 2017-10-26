//
//  PCCFileDataModel.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/25.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCFileDataModel.h"
#import "NSString+SubString.h"

@implementation PCCFileDataModel


- (instancetype)init{
    self = [super init];
    if(self != nil) {
        //        PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"4" describe:@"" isback:true];
        //        NSString *commandStr = [commandModel toJSONString];
        //        NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
        //        [[PCCSocketModel shareInstance] sendCmd:cmdStr];
        //        [PCCSocketModel shareInstance].cmdDelegate = self;
        
    }
    return self;
}

- (void)postFileDescirbeCmd:(NSString *)cmd {
    
    [[PCCSocketCmd shareInstance] sendCmd:cmd];
    [PCCSocketCmd shareInstance].cmdDelegate = self;;
}



#pragma mark -- SocketDelegate

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
        NSString *sss = [NSString subString:resultString FromElement:@"[" toElement:@"]"];
        NSDictionary *dict = @{@"fileMessage" : sss};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fileMessage" object:nil userInfo:dict];
    }
}

@end
