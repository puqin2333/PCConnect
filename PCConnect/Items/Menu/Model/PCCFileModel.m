//
//  PCCFileModel.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/24.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCFileModel.h"
#import "NSString+SubString.h"

@implementation PCCFileModel

- (instancetype)initWithFileType:(NSString *)fileType fileName:(NSString *)fileName fileSize:(long)fileSize{
    self = [super init];
    if (self !=nil) {
        _fileType = fileType;
        _fileSize = fileSize;
        _fileName = fileName;
    }
    return self;
}

@end

@implementation PCCFileDescribeModel

- (instancetype)initWithType:( BOOL)type name:(NSString *)name path:(NSString *)path{
    self = [super init];
    if (self !=nil) {
        _type = type;
        _name = name;
        _path = path;
    }
    return self;
}

//- (void)postFileDescirbeCmd:(NSString *)cmd {
//    
//    [[PCCSocketCmd shareInstance] sendCmd:cmd];
//    [PCCSocketCmd shareInstance].cmdDelegate = self;
//}
//
//
//#pragma mark -- SocketDelegate
//- (void)getCmdDataMessage:(NSData *)data {
//    int a;
//    if (data.length <= 4) {
//        int i;
//        [data getBytes: &i length: sizeof(i)];
//        a = CFSwapInt32BigToHost((uint32_t)i);
//        return;
//    } else {
//        
//        NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"resultString -- %@",resultString);
//        NSString *sss = [NSString subString:resultString FromElement:@"[" toElement:@"]"];
//        NSDictionary *dict = @{@"fileMessage" : sss};
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"fileMessage" object:nil userInfo:dict];
//    }
//}

@end
