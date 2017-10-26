//
//  PCCDiskDataModel.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/18.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCDiskDataModel.h"
#import "PCCCommandModel.h"
#import "NSString+SubString.h"

@implementation PCCDiskDataModel

- (instancetype)init{
    self = [super init];
    if(self != nil) {
        PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"4" describe:@"" isback:true];
        NSString *commandStr = [commandModel toJSONString];
        NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
        [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
        [PCCSocketCmd shareInstance].cmdDelegate = self;
        
    }
    return self;
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
        NSString *jsonString = [NSString subString:resultString FromElement:@"[" toElement:@"]"];
        NSArray *jsonArray = [PCCCommandModel arrayWithJsonString:jsonString];
        self.diskPartitionArray = [NSMutableArray arrayWithCapacity:jsonArray.count];
        self.diskArray = [NSMutableArray arrayWithCapacity:jsonArray.count];
        self.diskSpaceArray = [NSMutableArray arrayWithCapacity:jsonArray.count];
        for (NSUInteger i = 0; i < jsonArray.count; i++) {
            NSDictionary *dict = jsonArray[i];
            [self.diskSpaceArray addObject:dict[@"useInfo"]];
            [self.diskArray addObject:dict[@"path"]];
            [self.diskPartitionArray addObject:dict[@"drive"]];
        }
        
        NSArray *diskPartitionArray = _diskPartitionArray;
        NSArray *diskArray = _diskArray;
        NSArray *diskPaceArray = _diskSpaceArray;
        NSDictionary *resultDict = @{
                                     @"path" : diskArray,
                                     @"useInfo" : diskPaceArray,
                                     @"drive" : diskPartitionArray,
                                     };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"diskData" object:nil userInfo:resultDict];
    }
    
  
}

@end
