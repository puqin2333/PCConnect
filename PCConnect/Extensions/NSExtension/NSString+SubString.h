//
//  NSString+SubString.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/21.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SubString)

+ (NSString*)subString:(NSString *)string FromElement:(NSString *)startElement toElement:(NSString *)endElement;

@end
