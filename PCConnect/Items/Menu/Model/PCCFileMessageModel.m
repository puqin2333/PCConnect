//
//  PCCFileMessageModel.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/21.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCFileMessageModel.h"
#import "PCCCommandModel.h"
#import "NSString+SubString.h"

@implementation PCCFileMessageModel

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

// 向服务器发送获取当前目录的数据
- (void)postFileData:(NSString *)describe {
    PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"4" describe:describe isback:true];
    NSString *commandStr = [commandModel toJSONString];
    NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
    [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
    [PCCSocketCmd shareInstance].cmdDelegate = self;
}

#pragma mark --SocketCmdDelegate

- (void)getCmdDataMessage:(NSData *)data {
    int a;
    if (data.length <= 4) {
        int i;
        [data getBytes: &i length: sizeof(i)];
        a = CFSwapInt32BigToHost((uint32_t)i);
        return;
    } else {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"resulting--%@",resultString);
                NSString *jsonString = [NSString subString:resultString FromElement:@"[" toElement:@"]"];
                NSArray *jsonArray = [PCCCommandModel arrayWithJsonString:jsonString];
                self.fileNameArray = [NSMutableArray arrayWithCapacity:jsonArray.count];
                self.pathArray = [NSMutableArray arrayWithCapacity:jsonArray.count];
                self.isFileArray = [NSMutableArray arrayWithCapacity:jsonArray.count];
                for (NSUInteger i = 0; i < jsonArray.count; i++) {
                    NSDictionary *dict = jsonArray[i];
                    [self.fileNameArray addObject:dict[@"name"]];
                    [self.pathArray addObject:dict[@"path"]];
                    [self.isFileArray addObject:dict[@"type"]];
                }
                NSArray *fileNameArray = _fileNameArray;
                NSArray *pathArray = _pathArray;
                NSArray *isFileArray = _isFileArray;
                NSDictionary *resultDict = @{
                                             @"path" : pathArray,
                                             @"name" : fileNameArray,
                                             @"type" : isFileArray,
                                             };
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FileListData" object:nil userInfo:resultDict];
            });
        });
        
    }
}

@end
