//
//  NSString+PCCDictToJSON.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/10.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "NSString+PCCDictToJSON.h"

@implementation NSString (PCCDictToJSON)

+ (NSString *)dictToJson:(NSDictionary *)dict {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:(NSJSONWritingPrettyPrinted) error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"error--%@",jsonData);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0, jsonString.length};
    // 去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0, mutStr.length};
    // 去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    NSRange range3 = {20, mutStr.length - 20};
    // 将bool值 1 转换为 ture
    [mutStr replaceOccurrencesOfString:@"1" withString:@"true" options:NSLiteralSearch range:range3];
    return mutStr;
    
}
@end
