//
//  PCCFileMessageModel.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/21.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCCSocketCmd.h"

@interface PCCFileMessageModel : NSObject<PCCSocketCmdDelegate>

@property(nonatomic, strong) NSMutableArray *pathArray; //  磁盘路径
@property(nonatomic, strong) NSMutableArray *fileNameArray; // 文件名称
@property(nonatomic, strong) NSMutableArray *isFileArray;  //是否为文件类型

- (void)postFileData:(NSString *)describe;
@end
