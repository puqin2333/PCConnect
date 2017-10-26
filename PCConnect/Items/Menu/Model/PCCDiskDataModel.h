//
//  PCCDiskDataModel.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/18.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCCSocketCmd.h"

@interface PCCDiskDataModel : NSObject <PCCSocketCmdDelegate>

@property(nonatomic, strong) NSMutableArray *diskSpaceArray; // 磁盘空间大小
@property(nonatomic, strong) NSMutableArray *diskPartitionArray; // 磁盘分区名称
@property(nonatomic, strong) NSMutableArray *diskArray; //  磁盘目录
@end
