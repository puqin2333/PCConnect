//
//  PCCFileModel.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/24.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PCCFileModel : JSONModel

@property(nonatomic, copy) NSString *fileName;
@property(nonatomic, copy) NSString *fileType;
@property(nonatomic, assign) long fileSize;

- (instancetype)initWithFileType:(NSString *)fileType fileName:(NSString *)fileName fileSize:(long)fileSize;

@end

@interface PCCFileDescribeModel : JSONModel

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *path;
@property(nonatomic, assign) BOOL type;

- (instancetype)initWithType:( BOOL)type name:(NSString *)name path:(NSString *)path;

//- (void)postFileDescirbeCmd:(NSString *)cmd;

@end
