//
//  PCCMenuItem.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCMenuItem.h"

@implementation PCCMenuItem

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image {
    
    PCCMenuItem *item = [[self alloc] init];
    item.title = title;
    item.image = image;
    
    return item;
}

@end
