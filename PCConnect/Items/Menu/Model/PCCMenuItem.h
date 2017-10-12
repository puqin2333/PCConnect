//
//  PCCMenuItem.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PCCMenuItem : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIImage  *image;

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;

@end
