//
//  PCCDiskDataModel.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/18.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCDiskDataModel.h"
#import "PCCSocketModel.h"
#import "PCCCommandModel.h"

@implementation PCCDiskDataModel

- (instancetype)init{
    if(self == [super init]){
        
        PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"4" describe:@"" isback:true];
        NSString *commandStr = [commandModel toJSONString];
        NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
        [[PCCSocketModel shareInstance] sendCmd:cmdStr];
        
        NSLog(@"result-- %@",[PCCSocketModel shareInstance].resultString);
        
        
        self.diskSpaceArray = @[@18.0,@82.0,@14.0,@26.0];
        self.diskPartitionArray = @[@"C盘",@"新加卷1",@"新加卷2",@"新加卷3"];
    }
    return self;
}

@end
