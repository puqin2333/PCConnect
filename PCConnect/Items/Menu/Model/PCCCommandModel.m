//
//  PCCCommandModel.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/20.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCCommandModel.h"

@implementation PCCCommandModel

// 控制命令
- (instancetype)initWithType:(NSString *)type describe:(NSString *)describe isback:(BOOL)isback {
    self = [super init];
    if (self !=nil) {
        _type = type;
        _describe = describe;
        _isback = isback;
    }
    return self;
}

// 快捷命令
- (instancetype)initWithType:(NSString *)type isback:(BOOL)isback {
    self = [super init];
    if (self !=nil) {
        _type = type;
        _isback = isback;
    }
    return self;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dict;
}

+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *ary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return ary;
}

@end

@implementation PCCPointModel


- (instancetype)initWithTouchClick:(BOOL)isClick singleClick:(BOOL)isSingle doubleClick:(BOOL)isDouble rightClick:(BOOL) isRight map:(NSDictionary *)mapWayPath {
    if (self = [super init]) {
        self.click = isClick;
        self.singleClick = isSingle;
        self.doubleClick = isDouble;
        self.rightClick = isRight;
        self.map = mapWayPath;
    }
    return self;
}

@end
