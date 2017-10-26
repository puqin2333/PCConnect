//
//  NSString+SubString.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/21.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "NSString+SubString.h"

@implementation NSString (SubString)

+ (NSString*)subString:(NSString *)string FromElement:(NSString *)startElement toElement:(NSString *)endElement {
    NSRange startRange = [string rangeOfString:startElement];
    NSRange endRange = [string rangeOfString:endElement];
    NSString *substring = [string substringWithRange:NSMakeRange(startRange.location, endRange.location - startRange.location + 1)];
    return substring;
}

@end
