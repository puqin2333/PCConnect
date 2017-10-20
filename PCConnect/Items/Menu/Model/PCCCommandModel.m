//
//  PCCCommandModel.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/20.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCCommandModel.h"

@implementation PCCCommandModel

- (instancetype)initWithType:(NSString *)type describe:(NSString *)describe isback:(BOOL)isback {
    if (self = [super init]) {
        _type = type;
        _describe = describe;
        _isback = isback;
    }
    return self;
}
- (NSString *)getCommandJsonString {
    NSDictionary *commandDict = @{@"describe" : _describe,
                           @"isback" :  @(_isback),
                           @"type" : _type
                           };
    NSData *commandData = [NSJSONSerialization dataWithJSONObject:commandDict options: NSJSONWritingPrettyPrinted error:NULL];
    NSString *jsonStr = [[NSString alloc] initWithData:commandData encoding:NSUTF8StringEncoding] ;

    
    return jsonStr;
}

@end
